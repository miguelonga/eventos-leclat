require 'cloudinary'
require 'fileutils'
require 'csv'
require 'json'

cloudinary = Cloudinary.config do |config|
  config.cloud_name = 'la-colmena-que-dice-si'
  config.api_key = 282755476298832
  config.api_secret = 'wEAF-i04hbraF-KrqnO0yu7u3YM'
end

class Spreadsheet
  def initialize
    @static_pages = JSON.parse(File.read("./catalogo.json"))
  end

  def generate_json
    @static_pages = JSON.parse(File.read("./catalogo.json"))
    prepare_galleries
  end

  def get_static_page(slug)
    pages = @static_pages
    page = pages.select {|page| page['slug'] == slug}.first
    raise ArgumentError.new('Page not found') if page.nil?
    page
  end

  def get_static_pages_by_tag(tag)
    pages = @static_pages
    pages.select do |page|
      tags = page['tags'] || []
      tags.include?(tag)
    end
  end

  private

  def prepare_galleries
    new_data = @static_pages.map do |page|
      tag = page['cloudinary_tag'] || 'nothing'
      page['gallery'] = Cloudinary::Api.resources_by_tag(tag)['resources'].map {|resource| resource['url']}
      page['gallery'].map! {|image| resize_image_quallity(image, 25)}
      page
    end
    IO.write "./catalogo.json", JSON.pretty_generate(new_data)
  end

  def resize_image_quallity(image, quallity)
    return nil if image === ''
    image.split('upload/').first + 'upload/q_' + quallity.to_s + '/' + image.split('upload/').last
  end
end
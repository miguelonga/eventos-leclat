require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

class Spreadsheet
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'SpreadSheet Consultor'
  SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
  PRODUCT_PROPERTIES = ["name", "description", "category", "seo_keywords", "seo_title", "slug"]
  STATIC_PAGES_PAGE = 'Estaticas'
  SELL_PRODUCTS_PAGE = 'Venta'
  RENT_PRODUCTS_PAGE = 'Alquiler'

  def initialize(file_name, spreadsheet_id)
    @spreadsheet_id = spreadsheet_id
    @file_name = file_name
    write_json(file_name, spreadsheet_id)
  end

  def static_pages
    file = File.read("./#{@file_name}-static-pages-data.csv")
    file = JSON.parse(file)
    file.map {|page_data| StaticPage.new(page_data)}
  end

  def get_static_page(slug)
    pages = static_pages
    # pages = get_spreadsheet_data(STATIC_PAGES_PAGE, :page) unless File.exist?('./static-pages-data.csv')
    page = pages.select {|page| page.slug == slug}.first
    raise ArgumentError.new('Page not found') if page.nil?
    page
  end

  def get_static_pages_by_tag(tag)
    pages = static_pages
    pages.select do |page|
      tags = page.tags
      tags.include?(tag)
    end
  end

  def write_json(file_name, spreadsheet_id)
    static_pages = get_spreadsheet_data(STATIC_PAGES_PAGE, :page)
    IO.write "./#{file_name}-static-pages-data.csv", JSON.pretty_generate(static_pages)
    self
  end

  def auth(password)
    return encode(password) === 'eCLqyG4VQQ4GV'
  end

  def refresh
    write_json(@file_name, @spreadsheet_id)
    p "I've been refreshed"
  end

  private

  def initialize_service
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = APPLICATION_NAME
    api_key = 'AIzaSyDBz51eTHiAQ9VbNo_liPbnwHYvNmATj9c'
    service.key = api_key
    service
  end

  def get_spreadsheet_data(page_title, data_type)
    service = initialize_service
    range = "#{page_title.downcase}!A2:Z"

    response = service.get_spreadsheet_values(@spreadsheet_id, range)

    return [] if response.values.nil? || response.values.empty?
    response.values
  end

  def get_products(page_title=SELL_PRODUCTS_PAGE)
    products = get_spreadsheet_data(page_title, :product)
  end

  def build_objects(data, type)
    objects = []
    data.each do |object|
      objects << build_object(object, type)
    end
    objects
  end

  def build_object(data, type)
    product_data = {}
    return StaticPage.new(data) if type == :page
    data.each_with_index do |value, index|
      property = PRODUCT_PROPERTIES[index] if type == :product
      product_data[property] = value
    end
    product_data
  end

  def encode(text)
    text.tr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", "MOhqm0PnycUZeLdK8YvDCgNfb7FJtiHT52BrxoAkas9RWlXpEujSGI64VzQ31w")
  end
end

class StaticPage
  STATIC_PAGE_PROPERTIES = ["name", "excerpt", "short_description", "description", "cover_image", "seo_keywords", "seo_title", "slug", "tags", "gallery"]
  attr_reader :name, :excerpt, :short_description, :description, :cover_image, :seo_keywords, :seo_title, :slug, :tags, :gallery
  attr_writer :cover_image

  def initialize(data)
    page_data = {}
    data.each_with_index do |value, index|
      property = STATIC_PAGE_PROPERTIES[index]
      page_data[property] = value
    end

    @name = page_data['name'] || ''
    @excerpt = page_data['excerpt'] || ''
    @short_description = page_data['short_description'] || ''
    @description = page_data['description'] || ''
    @cover_image = page_data['cover_image'] || ''
    @seo_keywords = page_data['seo_keywords'] || ''
    @seo_title = page_data['seo_title'] || ''
    @slug = page_data['slug'] || ''
    @tags = page_data['tags'] || ''
    @gallery = (page_data['gallery'] || '').split(', ')

    @cover_image = resize_image_quallity(@cover_image, 25)
    @gallery.map! {|image| resize_image_quallity(image, 25)}
  end

  private

  def resize_image_quallity(image, quallity)
    image.split('upload/').first + 'upload/q_' + quallity.to_s + '/' + image.split('upload/').last
  end
end

require 'sinatra'
require 'json'
require './helpers/spreadsheet'
require './helpers/render'

helpers do
  include Render
end

spreadsheet = Spreadsheet.write_json('15gjjgS_5Y15rS66JGBZzqUcatMwiRBijHm0GnSWuRW4')
# spreadsheet = Spreadsheet

get '/' do
  erb :index
end

get '/:slug/page' do
  @static_page = spreadsheet.get_static_page(params[:slug])
  # @static_page.cover_image = resize_image_quallity(@static_page.cover_image, 25)
  # @static_page.gallery.map! do |image|
  #   resize_image_quallity(image, 25)
  # end
  erb :static_page
end

get '/decoracion-para-bodas' do
  @static_page = spreadsheet.get_static_page('decoracion-para-bodas')
  @static_pages = spreadsheet.get_static_pages_by_tag('bodas')
  erb :static_pages_by_tag
end

get '/decoracion-para-comuniones' do
  @static_page = spreadsheet.get_static_page('decoracion-para-comuniones')
  @static_pages = spreadsheet.get_static_pages_by_tag('comuniones')
  erb :static_pages_by_tag
end

get '/contacto' do
  erb :contact
end

post '/send_mail' do
  Mailer.send_mail(params[:name], params[:email], params[:subject], params[:message])
  redirect '/'
end





require 'sinatra'
require './helpers/spreadsheet'
require './helpers/render'

helpers do
  include Render
end

event_spreadsheet = Spreadsheet.new

get '/' do
  erb :index
end

get '/:slug/page' do
  @static_page = event_spreadsheet.get_static_page(params[:slug])
  erb :static_page
end

get '/decoracion-para-bodas' do
  @static_page = event_spreadsheet.get_static_page('decoracion-para-bodas')
  @static_pages = event_spreadsheet.get_static_pages_by_tag('bodas')
  erb :static_pages_by_tag
end

get '/decoracion-para-comuniones' do
  @static_page = event_spreadsheet.get_static_page('decoracion-para-comuniones')
  @static_pages = event_spreadsheet.get_static_pages_by_tag('comuniones')
  erb :static_pages_by_tag
end

get '/contacto' do
  erb :contact
end

post '/send_mail' do
  Mailer.send_mail(params[:name], params[:email], params[:subject], params[:message])
  redirect '/'
end
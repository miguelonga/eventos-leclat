require 'sinatra'
require 'json'
require 'dotenv'
require './helpers/mailer'
require './helpers/dson'

include Mailer

include Dson



get '/' do
  @products = Dson.products
  erb :index 
end

get '/catalogo' do
  @products = Dson.products
  @categories = Dson.categories
  erb :catalog
end

get '/catalogo/find/:find_by' do
  @products = Dson.find_all_products(params[:find_by])
  @categories = Dson.categories
  @breadcrumb = params[:find_by]
  erb :catalog
end

get '/catalogo/ver/:product' do
  @product = Dson.find_product(params[:product])
  @related_products = Dson.find_related_products(params[:products])
  erb :product_detail
end

# get '/blog' do
#   data = File.read('blog.json')
#   blog = Json.parse(data)
#   @posts = []
#   blog.each {|post| @posts << post}
#   puts @posts
#   erb :blog
# end

get '/contacto' do
  erb :contact
end

post '/send_mail' do
  Mailer.send_mail(params[:name], params[:email], params[:subject], params[:message])
  redirect '/'
end





require 'sinatra'
require 'json'
require 'dotenv'
require './helpers/mailer'
require './helpers/cloudinary'
require './helpers/dson'

include Mailer
include Cloudimages

dson = Dson.new("data.json")

get '/' do
  Cloudimages.config
  @products = dson.find_products_by("Carteles")
  puts Cloudinary::Api.resources_by_tag("love")["resources"].first["url"]
  erb :index 
end

get '/catalogo' do
  @products = dson.products
  @categories = dson.categories
  erb :catalog
end

get '/catalogo/find/:find_by' do
  @products = dson.find_products_by(params[:find_by])
  @categories = dson.categories
  @breadcrumb = params[:find_by]
  erb :catalog
end

get '/catalogo/ver/:product' do
  @product = dson.find_product(params[:product])
  @related_products = dson.find_related_products(@product)
  @categories = dson.categories
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





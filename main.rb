require 'sinatra'
require 'json'
require 'dotenv'
require './helpers/mailer'
require './helpers/cloudinary'
require './helpers/catalog'

include Mailer
include Cloudimages

catalog = Catalog.new(ProductFile.new("data.json"))

get '/' do
  @products = catalog.find_products_by("Carteles")
  erb :index
end

get '/catalogo' do
  @products = catalog.products
  @categories = catalog.categories
  erb :catalog
end

get '/catalogo/find/:find_by' do
  @products = catalog.find_products_by(params[:find_by])
  @categories = catalog.categories
  @breadcrumb = params[:find_by]
  erb :catalog
end

get '/catalogo/ver/:product' do
  @product = catalog.find_product(params[:product])
  @related_products = catalog.find_related_products(@product)
  @categories = catalog.categories
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





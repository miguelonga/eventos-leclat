require 'sinatra'
require 'json'


get '/' do
  erb :index
end

get '/catalogo' do
  data = File.read('data.json')
  catalog = JSON.parse(data)
  @products = []
  catalog.each {|category| @products << category["products"]}
  p @products.first[0]["images"]
  @categories = []
  catalog.each {|category| @categories << category }
  erb :catalog
end

get '/catalogo/find/:find_by' do
  data = File.read('data.json')
  catalog = JSON.parse(data)
  @products = []
  category = catalog.select{|category| category["name"] == params[:find_by]}
  @products << category[0]["products"]
  @categories = []
  catalog.each {|category| @categories << category }
  @breadcrumb = params[:find_by]
  erb :catalog
end

get '/contacto' do
  erb :contact
end





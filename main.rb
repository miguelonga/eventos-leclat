require 'sinatra'
require 'json'


get '/' do
  erb :layout
end

get '/catalogo' do
  data = File.read('data.json')
  catalog = JSON.parse(data)
  @products = []
  catalog.each {|category| @products << category["products"]}
  @categories = []
  catalog.each {|category| @categories << category }
  puts @categories
  erb :catalog, :layout => false
end
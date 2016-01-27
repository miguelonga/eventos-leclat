require 'sinatra'
require 'json'
require 'dotenv'
require './helpers/mailer'
# require './helpers/jsondb'
include Mailer
# include JsonDB


get '/' do
  erb :index
end

get '/catalogo' do
  data = File.read('data.json')
  catalog = JSON.parse(data)
  @products = []
  catalog.each {|category| @products << category["products"]}
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

post '/send_mail' do
  Mailer.send_mail(params[:name], params[:email], params[:subject], params[:message])
  redirect '/'
end





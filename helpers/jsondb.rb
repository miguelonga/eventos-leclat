require 'json'

module JsonDB
  def get_data
    data = File.read('data.json')
    catalog = JSON.parse(data)
    @products = []
    catalog.each {|category| @products << category["products"]}
    @categories = []
    catalog.each {|category| @categories << category }
  end 
end
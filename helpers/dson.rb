require 'json'

module Dson
	data = File.read('./data.json')
	@catalog = JSON.parse(data)

  def categories
    categories = []
    @catalog.each {|category| categories << category }
    categories
  end

  def products
    products = []
    @catalog.each {|category| products << category["products"]}
    products
  end

  def find_product_by(category_name)
    products = []
    #seleccionar categoria
    category = @catalog.select{|category| category["name"] == category_name }
    #productos de la cat
    products << category[0]["products"]
  end

	def find_product(product_name)
	  @product = []
	  @catalog.each do |category| 
	    @product += category["products"].select{|p| p["name"] == product_name}
	  end
    @product
	end

	def find_related_products(product)
	  related_products = []
	  @catalog.each do |category| 
	    related_products += category["products"].select{|p| p["tags"].include?(product[0]["tags"][0]) || p["tags"].include?(product[0]["tags"][1]) }
	  end 
    related_products
	end
end









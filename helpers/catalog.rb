require 'json'

class ProductFile
  attr_reader :catalog
  def initialize(datafile)
    data = File.read(datafile)
    @catalog = JSON.parse(data)
  end
end

class Catalog
  def initialize(catalog_source)
    @catalog = catalog_source.catalog
  end

  def categories
    categories = []
    @catalog.each {|category| categories << category }
    categories
  end

  def products
    products = []
    categories.each do |category|
      category["products"].each do |product|
        products << product
      end
    end
    products
  end

  def find_products_by(category_name)
    @catalog.select{|category| category["name"] == category_name }[0]["products"]
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
	    related_products += category["products"].select{|p| (p["tags"].include?(product[0]["tags"][0]) && p["name"] != product[0]["name"]) || (p["tags"].include?(product[0]["tags"][1]) && p["name"] != product[0]["name"]) }
	  end 
    related_products
	end
end









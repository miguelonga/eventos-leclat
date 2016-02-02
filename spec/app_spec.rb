require './helpers/dson'

describe 'Dson' do
  let(:dson) { Dson.new('./data_test.json') }

  it 'find products by category' do
    products_in_test = [{"name"=>"First product", "price"=>"10€", "tags"=>["tag", "second_tag"], "images"=>["first_image", "second_image"]}, {"name"=>"Second product", "price"=>"10€", "tags"=>["tag", "second_tag"], "images"=>["first_image", "second_image"]}]

    expect(dson.find_products_by("Test")).to eq products_in_test
  end
  it 'find an specific product by its name' do
    product = [{"name"=>"First product", "price"=>"10€", "tags"=>["tag", "second_tag"], "images"=>["first_image", "second_image"]}]

    expect(dson.find_product("First product")).to eq product
  end
  it 'find related products for a given product' do
    product = [{"name"=>"First product", "price"=>"10€", "tags"=>["tag", "second_tag"], "images"=>["first_image", "second_image"]}]
    related_products = [{"name"=>"Second product", "price"=>"10€", "tags"=>["tag", "second_tag"], "images"=>["first_image", "second_image"]}, {"name"=>"First product other cat", "price"=>"10€", "tags"=>["tag", "second_tag"], "images"=>["first_image", "second_image"]}, {"name"=>"Second product", "price"=>"10€", "tags"=>["tag", "second_tag"], "images"=>["first_image", "second_image"]}]

    expect(dson.find_related_products(product)).to eq related_products
  end
end
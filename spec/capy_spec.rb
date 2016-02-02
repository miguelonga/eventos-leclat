require 'capybara/rspec'

require './main'
Capybara.app = Sinatra::Application

describe "Home Page", :type => :feature do
  it "reders without correct content" do
    visit '/'

    expect(page).to have_content "Decorabodas"
  end
  it "render the products in class carteles" do
    visit '/'
    click_link('catalogo')

    expect(page).to have_content "Categorías"
  end
end

describe "Catalog Page", :type => :feature do
  it "reders without correct content" do
    visit '/catalogo'

    expect(page).to have_content "buscando"
  end
end


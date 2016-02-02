require 'capybara/rspec'
require './main'
Capybara.app = Sinatra::Application

describe "Home Page", :type => :feature do
  it "reders without error status" do
    visit '/'
    
    expect(page).to have_content "Decorabodas"
  end
  # it "render the products in class carteles" do
  #   visit '/'

  #   expect(page).to have_content 
  # end
end
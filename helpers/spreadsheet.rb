require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

module SpreadsheetHelper
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'SpreadSheet Consultor Finametrix'
  SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
  SPREADSHEET_ID = '15gjjgS_5Y15rS66JGBZzqUcatMwiRBijHm0GnSWuRW4'
  PRODUCT_PROPERTIES = ["name", "description", "category", "seo_keywords", "seo_title", "seo_slug"]

  def catalog
    file = File.read('./product-data.json')
    JSON.parse(file)
  end

  def get_products_by_category(category_name, page_title='Venta')
    catalog.select {|product| product['category'] == category_name}
  end

  def write_json
    products_data = get_products
    IO.write "./product-data.json", JSON.pretty_generate(products_data)
  end

  private

  def initialize_service
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = APPLICATION_NAME
    api_key = 'AIzaSyDfXyiFOLcDAdea3aZrswME6WBoGNCAmnY'
    service.key = api_key
    service
  end

  def get_spreadsheet_data(page_title)
    service = initialize_service
    range = "#{page_title.downcase}!A2:F"

    response = service.get_spreadsheet_values(SPREADSHEET_ID, range)

    return [] if response.values.nil? || response.values.empty?
    build_products(response.values)
  end

  def get_products(page_title='Venta')
    products = get_spreadsheet_data(page_title)
  end

  def build_products(data)
    products = []
    data.each do |product|
      products << build_product_data(product)
    end
    products
  end

  def build_product_data(product)
    product_data = {}
    product.each_with_index do |value, index|
      property = PRODUCT_PROPERTIES[index]
      product_data[property] = value
    end
    product_data
  end
end

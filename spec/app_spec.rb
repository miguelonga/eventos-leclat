require './helpers/spreadsheet'

describe 'Spreadsheet Service' do
  before(:all) do
    @spreadsheet = Spreadsheet.new('test','1FS9qHn-vl9go5OkJG67yfhungizypCLx5DPLg6cq8sw')
  end

  it 'create a page by an array' do
    page = @spreadsheet.get_static_page('test-slug')
    expect(page.class).to eq(StaticPage)
  end

  it 'retrieves a static page by slug' do
    page = @spreadsheet.get_static_page('test-slug')
    expect(page.name).to eq('test name')
  end

  it 'serves an empty static page with invalid slug' do
    expect {
      @spreadsheet.get_static_page('invalid-slug')
    }.to raise_error(ArgumentError, 'Page not found')
  end

  it 'retrieves all static pages by tag' do
    pages = @spreadsheet.get_static_pages_by_tag('test')
    expect(pages.size).to eq(1)
  end

  it 'dont fail if there arent tags' do
    pages = @spreadsheet.get_static_pages_by_tag('undefined_tag')
    expect(pages.size).to eq(0)
  end
end

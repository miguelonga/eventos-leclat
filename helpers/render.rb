require_relative 'spreadsheet'

module Render
  def paint_static_pages_list_by_tag(tag)
    pages = Spreadsheet.get_static_pages_by_tag(tag)
    list = ''
    pages.each do |page|
      list += " <li>
                  <a href='/#{page.slug}/page'>#{page.name}</a>
                </li>"
    end
    list
  end
end
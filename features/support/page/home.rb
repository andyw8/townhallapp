module Page
  class Home < Page::Base
  end
end

def home_page
  Page::Home.new
end

#World(Page)
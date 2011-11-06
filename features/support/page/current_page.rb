class CurrentPage < Page::Base    
end

def current_page
  CurrentPage.new
end

#World(Page)
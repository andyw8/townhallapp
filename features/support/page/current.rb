module Page
  class Current < Page::Base    
  end
end

def current_page
  Page::Current.new
end

#World(Page)
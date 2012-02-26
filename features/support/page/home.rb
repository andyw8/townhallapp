module Page
  class Home < Page::Base
    
    def path
      root_path
    end

  end
end

def home_page
  Page::Home.new
end

#World(Page)
class HomePage < Page::Base
    
  def path
    root_path
  end

end

def home_page
  HomePage.new
end

#World(Page)
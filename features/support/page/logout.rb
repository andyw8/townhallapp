module Page
  class Logout < Page::Base
  end
end

def logout_page
  Page::Logout.new
end

#World(PageModel)
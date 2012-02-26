module Page
  class Signin < Page::Base
  end
end

def signin_page
  Page::Signin.new
end

#World(Page)
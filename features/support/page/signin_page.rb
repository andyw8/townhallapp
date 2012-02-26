module Page
  class Signin < Page::Base
    
    def path
      new_user_session_path
    end

  end
end

def signin_page
  Page::Signin.new
end

#World(Page)
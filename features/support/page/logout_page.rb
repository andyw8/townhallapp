module Page
  
  class LogoutPage < Page::Base
        
    def path
      destroy_user_session_path
    end

  end
end

def logout_page
  Page::LogoutPage.new
end

#World(PageModel)
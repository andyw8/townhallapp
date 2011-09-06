module Page
  
  class LogoutPage < Page::Base
        
    def visit
      session.visit destroy_user_session_path
    end
    
  end
end

def logout_page
  Page::LogoutPage.new
end

#World(PageModel)
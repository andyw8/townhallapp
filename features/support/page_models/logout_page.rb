module PageModel
  
  class LogoutPage < PageModel::Base
        
    def visit
      session.visit destroy_user_session_path
    end
    
  end
end

def logout_page
  PageModel::LogoutPage.new
end

#World(PageModel)
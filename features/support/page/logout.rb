module Page
  class Logout < Page::Base
        
    def path
      destroy_user_session_path
    end

  end
end

def logout_page
  Page::Logout.new
end

#World(PageModel)
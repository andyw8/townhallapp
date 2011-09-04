module PageModel
  class LoginPage < PageModel::Base
    
    def visit
      session.visit new_user_session_path
    end
  end
end

def login_page
  PageModel::LoginPage.new
end

World(PageModel)
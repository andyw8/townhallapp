module PageModel
  class LoginPage < PageModel::Base
    
    def visit(series)
      session.visit new_user_session_path
    end
  end
end

def login_page
  PageModel::LoginPage.new
end

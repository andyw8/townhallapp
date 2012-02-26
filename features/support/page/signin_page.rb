class SigninPage < Page::Base
    
  def path
    new_user_session_path
  end

end

def signin_page
  SigninPage.new
end

#World(Page)
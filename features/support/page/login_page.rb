module Page
  
  class LoginPage < Page::Base
        
    SIGNED_IN_MESSAGE = "Signed in successfully."
    
    def path
      new_user_session_path
    end
    
    def visit
      session.visit path
    end
    
    def sign_in(email, password)
      session.fill_in 'Email', :with => email
      session.fill_in 'Password', :with => password
      session.click_button 'Sign in'
    end
    
  end
end

def login_page
  Page::LoginPage.new
end

#World(Page)
module PageModel
  
  class LoginPage < PageModel::Base
        
    def visit
      session.visit new_user_session_path
    end
    
    def sign_in(email, password)
      session.fill_in 'Email', with: email
      session.fill_in 'Password', with: password
      session.click_button 'Sign in'
      session.has_content?("Signed in successfully.").should == true
    end
    
  end
end

def login_page
  PageModel::LoginPage.new
end

#World(PageModel)
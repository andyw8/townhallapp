module Page
  class Login < Page::Base
    
    SIGNED_IN_MESSAGE = "Signed in successfully."

    def path
      new_user_session_path
    end

    def sign_in(email, password)
      fill_in 'Email', :with => email
      fill_in 'Password', :with => password
      click_button 'Sign in'
    end

  end
end

def login_page
  Page::Login.new
end

#World(Page)
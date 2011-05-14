PASSWORD = 'password'

def create_account(email)
  User.create!(
    :email => email,
    :password => PASSWORD,
    :password_confirmation => PASSWORD)
end

def sign_in(email)
  visit new_user_session_path
  fill_in 'Email', :with => email
  fill_in 'Password', :with => PASSWORD
  click_button 'Sign in'
  should have_content("Signed in successfully.")
end

Given /^I am authenticated$/ do
  create_account 'blah@testing.com'
  sign_in 'blah@testing.com'
end

Given /^I am authenticated as "([^"]*)"$/ do |email|
  create_account email
  sign_in email
end

Given /^I am not authenticated$/ do
  visit destroy_user_session_path
end

Given /^I have signed out$/ do
  visit destroy_user_session_path
end

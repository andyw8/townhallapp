PASSWORD = 'password'
EMAIL = 'blah@testing.com'

def create_account(email, password=PASSWORD)
  User.create!(
    :email => email,
    :password => password,
    :password_confirmation => password)
end

def sign_in(email, password=PASSWORD)
  login_page.visit
  login_page.sign_in(email, password)
end

Given /^I am authenticated$/ do
  create_account EMAIL
  sign_in EMAIL
end

Given /^I am authenticated as "([^"]*)"$/ do |email|
  create_account email
  sign_in email
end

Given /^I am not authenticated$/ do
  logout_page.visit
end

Given /^I have signed out$/ do
  logout_page.visit
end

Given /^I am signed up as "([^"]*)"$/ do |email_and_password|
  elements = email_and_password.split('/')
  create_account(elements.first, elements.last)
end

Given /^I am signed in as "([^"]*)"$/ do |email_and_password|
  elements = email_and_password.split('/')
  email = elements.first
  password = elements.last
  create_account(email, password)
  sign_in(email, password)
end

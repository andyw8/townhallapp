PASSWORD = 'password'

def create_account(email, password=PASSWORD)
  User.create!(
    email: email,
    password: password,
    password_confirmation: password)
end

def sign_in(email, password=PASSWORD)
  login_page.visit
  login_page.sign_in(email, password)
end

def create_account_and_sign_in(email)
  create_account email
  sign_in email
end

Given /^I am authenticated$/ do
  create_account_and_sign_in 'blah@testing.com'
end

Given /^I am authenticated as "([^"]*)"$/ do |email|
  create_account_and_sign_in email
end

Given /^I am not authenticated$/ do
  logout_page.visit
end

Given /^I have signed out$/ do
  logout_page.visit
end

Given /^I am signed up as "([^"]*)"$/ do |email_and_password|
  email = email_and_password.split('/').first
  password = email_and_password.split('/').last
  create_account(email, password)
end

Given /^I am signed in as "([^"]*)"$/ do |email_and_password|
  email = email_and_password.split('/').first
  password = email_and_password.split('/').last
  create_account(email, password)
  sign_in(email, password)
end



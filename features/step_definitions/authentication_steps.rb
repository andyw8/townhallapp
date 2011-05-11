def register_and_authenticate(email)
  visit new_user_registration_path
  fill_in 'Email', :with => email
  fill_in 'Password', :with => 'hello1'
  fill_in 'Password confirmation', :with => 'hello1'
  click_button "Sign up"
  page.should have_content('Welcome! You have signed up successfully.')
end

Given /^I am authenticated$/ do
  register_and_authenticate 'blah@testing.com'
end

Given /^I am authenticated as "([^"]*)"$/ do |email|
  register_and_authenticate email
end

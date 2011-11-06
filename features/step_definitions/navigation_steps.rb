Then /^I should be on the sign\-in page$/ do
  page.current_url.should == new_user_session_url
end

Then /^I should be on the home page$/ do
  page.current_path.should == home_page.path
end

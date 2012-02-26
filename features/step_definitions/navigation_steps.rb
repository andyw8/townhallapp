Then /^I should be on the sign\-in page$/ do
  current_path.should == new_user_session_path
end

Then /^I should be on the home page$/ do
  current_path.should == root_path
end

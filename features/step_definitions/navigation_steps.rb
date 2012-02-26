Then /^I should be on the sign\-in page$/ do
  signin_page.on?.should be_true
end

Then /^I should be on the home page$/ do
  page.current_path.should == home_page.path
end

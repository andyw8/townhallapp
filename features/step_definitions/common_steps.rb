Then /^I should see the error "([^"]*)"$/ do |message|
  current_page.errors.should include(message)
end

Then /^I should see the alert "([^"]*)"$/ do |message|
  current_page.alert.should == message
end

Then /^I should see the notice "([^"]*)"$/ do |message|
  current_page.notice.should == message
end

Then /^I should see a message "([^"]*)"$/ do |message|
  current_page.should have_message(message)
end

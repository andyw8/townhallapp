Then /^I should see the error "([^"]*)"$/ do |message|
  should have_css('.error_messages li', message)  
end

Then /^I should see the alert "([^"]*)"$/ do |message|
  find('#flash_alert').text.should == message
end

Then /^I should see the notice "([^"]*)"$/ do |message|
  find('#flash_notice').text.should == message
end

Then /^I should see a message "([^"]*)"$/ do |message|
  should have_content(message)
end

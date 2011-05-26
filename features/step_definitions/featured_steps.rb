Given /^the next random submission will be "([^"]*)"$/ do |name|
  submission = Submission.find_by_name(name)
  RandomElementPicker.stub(:random_element => submission)
end

Then /^the featured submission should be "([^"]*)"$/ do |name|
  should_not have_css('#featured-submission .name', :text => name)
end

Then /^I should see a message that I have voted on all the submissions$/ do
  should have_css('.all-voted-on')
end

Then /^I should not see a message that I have voted on all the submissions$/ do
  should_not have_css('.all-voted-on')
end

Then /^I should not see a featured submission$/ do
  should_not have_css('#featured-submission')
end

Then /^I should see a featured submission$/ do
  should have_css('#featured-submission')
end

def series_page
  PageModel::SeriesPage.new(page)
end

Given /^the next random submission will be "([^"]*)"$/ do |name|
  submission = Submission.find_by_name(name)
  RandomElementPicker.stub(:random_element => submission)
end

Then /^the featured submission should be "([^"]*)"$/ do |name|
  series_page.feature_submission_name.should == name
end

Then /^I should see a message that I have voted on all the submissions$/ do
  series_page.has_all_voted_on_message?.should == true
end

Then /^I should not see a message that I have voted on all the submissions$/ do
  series_page.has_all_voted_on_message?.should == false
end

Then /^I should not see a featured submission$/ do
  series_page.has_featured_submission?.should == false
end

Then /^I should see a featured submission$/ do
  series_page.has_featured_submission?.should == true
end

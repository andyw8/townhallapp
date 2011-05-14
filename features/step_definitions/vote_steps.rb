Given /^that series has a submission "([^"]*)" with (\d+) votes/ do |submission_name, votes|
  submission = Factory.create(:submission, :name => submission_name, :series => Series.last)
  votes.to_i.times do
    Factory.create(:vote, :submission => submission)
  end
end

When /^I click the vote button next to "([^"]*)"$/ do |submission_name|
  submission = Submission.find_by_name(submission_name)
  within("#submission-#{submission.id}") do
    click_button 'Vote'
  end
end

Then /^I should not see any vote buttons$/ do
  all('input[value="Vote"]').should be_empty
end

Then /^I should not see a Vote button next to "([^"]*)"$/ do |submission_name|
  submission = Submission.find_by_name(submission_name)
  should_not have_css("#submission-#{submission.id} input[value='Vote']")
end

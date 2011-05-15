Given /^that series has a submission "([^"]*)" with (\d+) plus votes and (\d+) minus votes$/ do |submission_name, plus_votes, minus_votes|
  submission = Factory.create(:submission, :name => submission_name, :series => Series.last)
  plus_votes.to_i.times do
    Factory.create(:plus_vote, :submission => submission)
  end
  minus_votes.to_i.times do
    Factory.create(:minus_vote, :submission => submission)
  end
end

Given /^that series has a submission "([^"]*)" with no votes$/ do |submission_name|
  submission = Factory.create(:submission, :name => submission_name, :series => Series.last)
end

Then /^I should see "([^"]*)" with a (\d+) plus votes and (\d+) minus votes$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "([^"]*)" with (\d+) plus votes and (\d+) minus votes$/ do |submission_name, plus_votes, minus_votes|
  submission = Submission.find_by_name(submission_name)
  within("#submission-#{submission.id}") do
    should have_css('.plus .value', :text => plus_votes)
    should have_css('.minus .value', :text => minus_votes)
  end
end

When /^I click the "([^"]*)" button next to "([^"]*)"$/ do |button_label, submission_name|
  submission = Submission.find_by_name(submission_name)
  within("#submission-#{submission.id}") do
    click_button button_label
  end
end

Then /^I should not see any vote buttons$/ do
  all('input[value="Vote"]').should be_empty
end

Then /^I should not see a Vote button next to "([^"]*)"$/ do |submission_name|
  submission = Submission.find_by_name(submission_name)
  should_not have_css("#submission-#{submission.id} input[value='Vote']")
end

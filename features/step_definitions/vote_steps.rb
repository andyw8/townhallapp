Given /^that series has a submission "([^"]*)" with (\d+) plus votes and (\d+) minus votes$/ do |submission_name, plus_votes, minus_votes|
  submission = Factory(:submission, name: submission_name, series: last_series)
  plus_votes.to_i.times do
    Factory(:plus_vote, submission: submission)
  end
  minus_votes.to_i.times do
    Factory(:minus_vote, submission: submission)
  end
end

Given /^that series has a submission "([^"]*)" with no votes$/ do |submission_name|
  submission = Factory(:submission, name: submission_name, series: last_series)
end

Then /^I should see "([^"]*)" with (\d+) plus votes and (\d+) minus votes$/ do |submission_name, plus_votes, minus_votes|
  submission = Submission.find_by_name(submission_name)
  within("#submission-#{submission.id}") do
    should have_css('.plus .value', text: plus_votes)
    should have_css('.minus .value', text: minus_votes)
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

Then /^I should not see a vote review for that submission$/ do
  submission = last_submission
  visit series_path(submission.series)
  should_not have_css("#submission-#{submission.id} .vote-review")
end

Given /^a user has voted for that submission$/ do
  Factory(:vote, vote: 'PLUS', submission: last_submission)
end

Given /^I have voted (on|for|against) that submission$/ do |position|
  position = "for" if position == "on"
  submission = last_submission
  visit series_path(submission.series)
  within("#submission-#{submission.id}") do
    click_button "Vote #{position.titleize}"
  end
end

Then /^I should see a vote review "([^"]*)" for that submission$/ do |review|
  submission = last_submission
  visit series_path(submission.series)
  should have_css("#submission-#{submission.id} .vote-review", text: review)
end

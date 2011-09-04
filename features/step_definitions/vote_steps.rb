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
  plus_vote_count(submission).should == plus_votes
  minus_vote_count(submission).should == minus_votes
end

When /^I click the "([^"]*)" button next to "([^"]*)"$/ do |button_label, submission_name|
  series_page.click_button_for_submission(button_label, submission)
end

Then /^I should not see any vote buttons$/ do
  vote_buttons.should be_empty
end

Then /^I should not see a Vote button next to "([^"]*)"$/ do |submission_name|
  submission = Submission.find_by_name(submission_name)
  has_vote_button?(submission).should == false
end

Then /^I should not see a vote review for that submission$/ do
  submission = last_submission
  visit series_path(submission.series)
  has_vote_review?(submission).should == false
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
  vote_review_text(submission).should == review
end

def vote_review_text(submission)
  find("#submission-#{submission.id} .vote-review").text.strip
end

def has_vote_review?(submission)
  has_css?("#submission-#{submission.id} .vote-review")
end

def has_vote_button?(submission)
  has_css?("#submission-#{submission.id} input[value='Vote']")
end

def vote_buttons
  all('input[value="Vote"]')
end

def plus_vote_count(submission)
  within("#submission-#{submission.id}") do
    should have_css('.plus .value', text: plus_votes)
  end
end

def minus_vote_count(submission)
  within("#submission-#{submission.id}") do
    should have_css('.minus .value', text: minus_votes)
  end 
end

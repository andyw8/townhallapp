Given /^that series has a submission with (\d+) plus votes? and (\d+) minus votes??$/ do |plus_votes, minus_votes|
  @submission = Factory(:submission, :series => @series)
  plus_votes.times do
    Factory(:plus_vote, :submission => @submission)
  end
  minus_votes.times do
    Factory(:minus_vote, :submission => @submission)
  end
end

Given /^that series has a submission with no votes$/ do
  @submission = Factory(:submission, :series => @series)
end

Then /^that submission should have (\d+) plus votes? and (\d+) minus votes?$/ do |plus_votes, minus_votes|
  series_page.plus_vote_count(@submission).should == plus_votes
  series_page.minus_vote_count(@submission).should == minus_votes
end

When /^I vote for that submission$/ do
  series_page.click_button_for_submission("Vote For", @submission.name)
end

When /^I vote against that submission$/ do
  series_page.click_button_for_submission("Vote Against", @submission.name)
end

Then /^I should not be able to vote$/ do
  series_page.vote_buttons.should be_empty
end

Then /^I should not see a Vote button next to that submission$/ do
  series_page.should_not have_vote_button(@submission)
end

Then /^I should not see a vote review for that submission$/ do
  visit series_path(@submission.series)
  series_page.should_not have_vote_review(@submission)
end

Given /^(?:a|another) user has voted for that submission$/ do
  Factory(:vote, :vote => 'PLUS', :submission => @submission)
end

Given /^I have voted (on|for|against) that submission$/ do |position|
  position = "for" if position == "on"
  visit series_path(@submission.series)
  series_page.vote_on_submission @submission, position
end

Given /^I have voted on the submission "([^"]*)" in that series$/ do |submission_name|
  submission = @series.submissions.find_by_name(submission_name)
  visit series_path(@series)
  series_page.vote_on_submission submission, 'for'
end

Then /^I should see a vote review "([^"]*)" for that submission$/ do |review|
  visit series_path(@submission.series)
  series_page.vote_review_text(@submission).should == review
end

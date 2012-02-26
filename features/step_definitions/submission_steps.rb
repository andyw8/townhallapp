def verify_submissions_count(series, count)
  visit series_path(series)
  series_page.submissions_count.should == count
end

def verify_submission_author(submission, email)
  series_page.submission_author_email(submission).should == email
end

def verify_submissions_order(actual_submissions)
  expected_submissions = series_page.submission_names
  expected_submissions.should == actual_submissions
end

def create_submissions_for_series(submission_hashes, series)
  submission_hashes.each do |hash|
    Factory(:submission,
      :name => hash['name'],
      :created_at => Chronic.parse(hash['created']),
      :series => series)
  end
end

def create_submissions_and_series(hashes)
  hashes.each do |hash|
    series = Factory(:series, :name => hash['series'])
    Factory(:submission,
      :name => hash['name'],
      :series => series)
  end
end

Given /^no are no submissions for that series$/ do
  # no code needed
end

Given /^a submission exists$/ do
  @submission = Factory(:submission)
end

When /^I view that submission's series$/ do
  visit series_path(@submission.series)
end

Given /^the following submissions and series:$/ do |table|
  create_submissions_and_series(table.hashes)
end

Then /^(\d+) submissions should exist for that series$/ do |count|
  verify_submissions_count(@series, count)
end

Then /^I should see that the author of "([^"]*)" is "([^"]*)"$/ do |submission_name, email|
  submission = Submission.find_by_name(submission_name)
  verify_submission_author(submission, email)
end

Given /^a submission exists for that series$/ do
  @submission = Factory(:submission, :series => @series)
end

Given /^that series has a submission "([^"]*)"$/ do |name|
  @submission = Factory(:submission, :name => name, :series => @series)
end

When /^I try to create a submission without a name$/ do
  series = Factory(:series)
  visit series_path(series)
  click_link 'New Submission'
  new_submission_page.create('')
end

When /^I post a submission "([^"]*)"$/ do |name|
  series_page.new_submission
  new_submission_page.create(name)
end

Then /^I should see only the submission "([^"]*)"$/ do |expected|
  actual = all('#submissions .name').collect(&:text)
  actual.should == [expected]
end

Then /^I should not see a New Submission link$/ do
  should have_no_link('New Submission')
end

Then /^there should be no submissions for that series$/ do
  visit series_path(@series)
  series_page.should_not have_submissions
end
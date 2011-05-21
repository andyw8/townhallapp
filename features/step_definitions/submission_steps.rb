def last_submission
  Submission.last
end

def verify_submissions_count(series, count)
  visit series_path(series)
  all('#submissions li').should have(count).items
end

def verify_submission_author(submission, email)
  should have_css("#submission-#{submission.id} .author-name", text: email)
end

def verify_submissions_order(actual_submissions)
  expected_submissions = all('#submissions .name').collect(&:text)
  expected_submissions.should == actual_submissions
end

def create_submissions_for_series(submission_hashes, series)
  submission_hashes.each do |hash|
    Factory(:submission,
      name: hash['name'],
      created_at: Chronic.parse(hash['created']),
      series: series)
  end
end

def create_submissions_and_series(hashes)
  hashes.each do |hash|
    series = Factory(:series, name: hash['series'])
    Factory(:submission,
      name: hash['name'],
      series: series)
  end
end

Given /^I am creating a new submission for a series$/ do
  visit series_path(Factory(:series))
  click_link "New Submission"
end

Given /^no are no submissions for that series$/ do
  # no code needed
end

Given /^a submission exists$/ do
  Factory(:submission)
end

When /^I view that submission's series$/ do
  visit series_path(last_submission.series)
end

Given /^the following submissions for that series:$/ do |table|
  create_submissions_for_series(table.hashes, last_series)
end

Given /^the following submissions and series:$/ do |table|
  create_submissions_and_series(table.hashes)
end

Then /^I should see the submissions in the order:$/ do |table|
  verify_submissions_order(table.raw.flatten)
end

Then /^(\d+) submissions should exist for that series$/ do |count|
  verify_submissions_count(last_series, count.to_i)
end

Then /^I should see that the author of "([^"]*)" is "([^"]*)"$/ do |submission_name, email|
  submission = Submission.find_by_name(submission_name)
  verify_submission_author(submission, email)
end

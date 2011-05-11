def view_submissions_for_a_series
  some_user = User.create!(:email => 'andy@example.com', :password => 'hello1')
  @series = some_user.series.create!(:name => 'My Series')
  visit "/series/#{@series.id}/submissions"
end

def verify_submissions_count(count)
  visit series_submissions_path(@series)
  page.all('ul li').length.should be(count)
end

Given /^I am creating a new submission for a series$/ do
  some_user = User.create!(:email => 'andy@example.com', :password => 'hello1')
  @series = some_user.series.create!(:name => 'My Series')
  visit series_submissions_path(@series)
  click_link "New Submission"
end

Then /^(\d+) submissions should exist for that series$/ do |count|
  verify_submissions_count(count.to_i)
end

Given /^I am viewing the submissions for a series$/ do
  view_submissions_for_a_series
end

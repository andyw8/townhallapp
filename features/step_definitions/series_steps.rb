def create_series
  @series = Factory.create(:series)
end

def view_series(series)
  visit "/series/#{series.id}"
end

def create_and_visit_series
  create_series
  view_series(@series)
end

def verify_series_count(count)
  visit series_index_path
  page.all('ul li').size.should be(count)
end

Given /^I am viewing a series$/ do
  create_and_visit_series
end

When /^I view the series "([^"]*)"$/ do |name|
  @series = Series.find_by_name(name)
  view_series(@series)
end

Given /^a series exists$/ do
  @series = Factory.create(:series)
end

When /^I view that series$/ do
  raise 'no series' unless @series
  visit "/series/#{@series.id}/submissions"
end

Given /^no series exist$/ do
  Series.delete_all
end

Given /^I am creating a new series$/ do
  visit new_series_path
end

Given /^I leave the "([^"]*)" field blank$/ do |arg1|
  # no code necessary - this step is to help make the scenario readable
end

Then /^I should see the series "([^"]*)"$/ do |name|
  page.should have_css('h1', :text => name)
end

Then /^(\d+) series should exist$/ do |count|
  verify_series_count(count.to_i)
end

Then /^the series owner of "([^"]*)" should be shown as "([^"]*)"$/ do |series_name, email|
  page.should have_content("#{series_name} (#{email})")
end

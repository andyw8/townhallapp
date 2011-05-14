def create_series
  Factory.create(:series)
end

def view_series(series)
  visit series_path(series)
end

def verify_series_count(count)
  visit series_index_path
  all('ul li').size.should be(count)
end

Given /^the following series:$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:series,
      :name => hash['name'],
      :created_at => Chronic.parse(hash['created']))
  end
end

Given /^I am viewing a series$/ do
  create_series
  view_series(Series.last)
end

When /^I view the series "([^"]*)"$/ do |name|
  series = Series.find_by_name(name)
  view_series(series)
end

Given /^a series exists$/ do
  series = Factory.create(:series)
end

When /^I view that series$/ do
  visit series_path(Series.last)
end

When /^I view the series index$/ do
  visit series_index_path
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
  should have_css('h1', :text => name)
end

Then /^(\d+) series should exist$/ do |count|
  verify_series_count(count.to_i)
end

Then /^the series owner of "([^"]*)" should be shown as "([^"]*)"$/ do |series_name, email|
  should have_content("#{series_name} (#{email})")
end

Then /^I should see the series in the order:$/ do |table|
  actual_series = table.raw.flatten
  expected_series = all('ul#series li a').collect(&:text)
  expected_series.should match_array(actual_series)
end

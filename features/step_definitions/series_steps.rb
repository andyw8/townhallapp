def create_series
  Factory.create(:series)
end

def view_series(series)
  visit series_path(series)
end

def verify_series_count(count)
  visit series_index_path
  all('#series li').should have(count).items
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
  Factory.create(:series)
end

Given /^a series exists named "([^"]*)"$/ do |name|
  Factory.create(:series, :name => name)
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
  expected_series.should == actual_series
end

When /^I create a new series$/ do
  Factory.create(:series)
end

Then /^the stats for that series should be:$/ do |table|
  visit series_index_path
  values = table.rows_hash
  series = Series.last
  within("#series-#{series.id}") do
    should have_css(".users .value", :text => values['users'])
    should have_css(".votes .value", :text => values['votes'])
    should have_css(".submissions .value", :text => values['submissions'])
  end
end

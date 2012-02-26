def create_series
  Factory(:series)
end

Given /^the following series:$/ do |table|
  table.hashes.each do |hash|
    Factory(:series,
      :name => hash['name'],
      :created_at => Chronic.parse(hash['created']))
  end
end

Given /^I am on the series index page$/ do
  visit series_index_path
end

Given /^I am viewing a series$/ do
  @series = create_series
  visit series_path(@series)
end

When /^I view the series "([^"]*)"$/ do |name|
  series = Series.find_by_name(name)
  visit series_path(series)
end

Given /^a series exists$/ do
  @series = Factory(:series)
end

Given /^a series exists named "([^"]*)"$/ do |name|
  @series = Factory(:series, :name => name)
end

When /^I view that series$/ do
  visit series_path(@series)
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
  series_index_page.series_names.should_includename
end

Then /^(\d+) series should exist$/ do |count|
  visit series_index_path
  series_index_page.series_count.should == count
end

Then /^the series owner of "([^"]*)" should be shown as "([^"]*)"$/ do |series_name, email|
  should have_content("#{series_name} (#{email})")
end

Then /^I should see the series in the order:$/ do |table|
  expected_series = table.raw.flatten
  series_index_page.series_names.should == expected_series
end

When /^I create a new series$/ do
  @series = Factory(:series)
end

When /^I create a new series "([^"]*)"$/ do |name|
  visit new_series_path
  new_series_page.create name
end

Then /^the stats for that series should be:$/ do |table|
  visit series_index_path
  expected_values = table.rows_hash
  actual_values = series_index_page.series_list_contents[@series.name]
  actual_values[:users].should == expected_values[:users].to_i
  actual_values[:votes].should == expected_values[:votes].to_i
  actual_values[:submissions].should == expected_values[:submissions].to_i
end

Then /^that series should have (\d+) votes$/ do |count|
  # TODO should verify through UI, not DB
  @series.votes_count.should == count
end

When /^I try to create a new series$/ do
  visit new_series_path
end

When /^I try to create a series without a name$/ do
  visit new_series_path
  new_series_page.create ''
end

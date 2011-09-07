def last_series
  Series.last
end

def create_series
  Factory(:series)
end

Given /^the following series:$/ do |table|
  table.hashes.each do |hash|
    Factory(:series,
      name: hash['name'],
      created_at: Chronic.parse(hash['created']))
  end
end

Given /^I am on the series index page$/ do
  series_index_page.visit
end

Given /^I am viewing a series$/ do
  create_series
  series_page.visit(last_series)
end

When /^I view the series "([^"]*)"$/ do |name|
  series = Series.find_by_name(name)
  series_page.visit(series)
end

Given /^a series exists$/ do
  Factory(:series)
end

Given /^a series exists named "([^"]*)"$/ do |name|
  Factory(:series, name: name)
end

When /^I view that series$/ do
  series_page.visit last_series
end

When /^I view the series index$/ do
  series_index_page.visit
end

Given /^no series exist$/ do
  Series.delete_all
end

Given /^I am creating a new series$/ do
  new_series_page.visit
end

Given /^I leave the "([^"]*)" field blank$/ do |arg1|
  # no code necessary - this step is to help make the scenario readable
end

Then /^I should see the series "([^"]*)"$/ do |name|
  series_index_page.series_names.include?(name).should == true
end

Then /^(\d+) series should exist$/ do |count|
  series_index_page.visit
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
  Factory(:series)
end

Then /^the stats for that series should be:$/ do |table|
  series_index_page.visit
  values = table.rows_hash
  #that_series = series_index_page.get_series(last_series)
  that_series = series_index_page.all_series[last_series.name]
  that_series['users'].should == values['users'].to_i
  that_series['votes'].should == values['votes'].to_i
  that_series['submissions'].should == values['submissions'].to_i
  p series_index_page.all_series
end

Then /^that series should have (\d+) votes$/ do |count|
  # should verify through UI, not DB
  last_series.votes_count.should == count.to_i
end

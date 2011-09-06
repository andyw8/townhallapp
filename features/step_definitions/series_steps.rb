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
  should have_css('h1', text: name)
end

Then /^(\d+) series should exist$/ do |count|
  series_index_page.visit
  series_index_page.series_count.should == count.to_i
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
  Factory(:series)
end

Then /^the stats for that series should be:$/ do |table|
  series_index_page.visit
  values = table.rows_hash
  within("#series-#{last_series.id}") do
    should have_css(".users .value", text: values['users'])
    should have_css(".votes .value", text: values['votes'])
    should have_css(".submissions .value", text: values['submissions'])
  end
end

Then /^that series should have (\d+) votes$/ do |count|
  # should verify through UI, not DB
  last_series.votes_count.should == count.to_i
end

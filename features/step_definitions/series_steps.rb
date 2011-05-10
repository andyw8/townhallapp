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
  visit series_index_path
  page.all('ul li').size.should be(count.to_i)
end


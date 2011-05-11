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
  visit series_index_path
  page.all('ul li').size.should be(count.to_i)
end

Then /^the series owner of "([^"]*)" should be shown as "([^"]*)"$/ do |series_name, email|
  page.should have_content("#{series_name} (#{email})")
end

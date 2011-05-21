Then /^the page title should be "([^"]*)"$/ do |title|
  should have_css('h1', text: title)
end

Then /^the window title should be "([^"]*)"$/ do |title|
  should have_css('title', text: title)
end

Then /^the page title should be "([^"]*)"$/ do |title|
  series_page.page_title.should == title  
end

Then /^the window title should be "([^"]*)"$/ do |title|
  series_page.window_title.should == title
end

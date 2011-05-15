def verify_submissions_count(series, count)
  visit series_path(series)
  all('#submissions li').should have(count).items
end

Given /^I am creating a new submission for a series$/ do
  series = Factory(:series)
  visit series_path(series)
  click_link "New Submission"
end

Given /^no are no submissions for that series$/ do
  # no code needed
end

Given /^the following submissions for that series:$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:submission,
      :name => hash['name'],
      :created_at => Chronic.parse(hash['created']),
      :series => Series.last)
  end
end

Given /^a series with the following submissions:$/ do |table|
  series = Factory.create(:series)
  table.hashes.each do |hash|
    submission = Factory.create(:submission, :name => hash['name'], :series => series, :score => hash['score'].to_i)
  end
end

Given /^the following submissions:$/ do |table|
  table.hashes.each do |hash|
    series = Factory.create(:series, :name => hash['series'])
    Factory.create(:submission,
      :name => hash['name'],
      :series => series)
  end
end

Then /^I should see the submissions in the order:$/ do |table|
  actual_submissions = table.raw.flatten
  expected_submissions = all('#submissions .name').collect(&:text)
  expected_submissions.should == actual_submissions
end

Then /^(\d+) submissions should exist for that series$/ do |count|
  verify_submissions_count(Series.last, count.to_i)
end




Given /^a series with these submissions and votes:$/ do |table|
  series = Factory(:series)
  table.hashes.each do |hash|
    submission = Factory(:submission, :series => series, :name => hash['name'])
    plus_votes = hash['plus votes'].to_i
    minus_votes = hash['minus votes'].to_i
    plus_votes.times { Factory(:plus_vote, :submission => submission) }
    minus_votes.times { Factory(:minus_vote, :submission => submission) }
  end
end

Then /^the submissions should be in the order:$/ do |table|
  visit series_path(Series.last)
  verify_submissions_order(table.raw.flatten)
end

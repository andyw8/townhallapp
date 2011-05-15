Factory.define :submission do |s|
  s.name "Submission"
  s.association :user
  s.association :series
end

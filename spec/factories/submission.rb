FactoryGirl.define do
  factory :submission do
    name "Submission"
    association :user
    association :series
  end
end

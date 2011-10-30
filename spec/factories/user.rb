FactoryGirl.define do
  factory :user do
    sequence :email do { |n| "person#{n}@example.com" }
    password "hello1"
  end
end

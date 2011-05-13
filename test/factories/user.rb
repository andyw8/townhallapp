Factory.define :user do |u|
  u.sequence :email do |n|
    "person#{n}@example.com"
  end
  u.password "hello1"
end
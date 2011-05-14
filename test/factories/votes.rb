Factory.define :vote do |f|
  f.vote "PLUS"
  f.association :submission
  f.association :user
end

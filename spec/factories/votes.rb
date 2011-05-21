Factory.define :vote do |f|
  f.vote "PLUS"
  f.association :submission
  f.association :user
end

Factory.define :plus_vote, parent: vote do |f|
  f.vote "PLUS"
end

Factory.define :minus_vote, parent: vote do |f|
  f.vote "MINUS"
end
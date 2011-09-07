# convert digits into integers
Transform /^(-?\d+)$/ do |number|
  number.to_i
end
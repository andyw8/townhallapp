require 'spec_helper'

describe Vote do

  it do
    should validate_presence_of(:user)
    should validate_presence_of(:submission)
    should validate_presence_of(:vote)
    should belong_to(:submission)
    should belong_to(:user)
  end

  it "is valid with a vote of 'PLUS'" do
    Factory.build(:vote, :vote => 'PLUS').should be_valid
  end

  it "is invalid with a vote of 'FOO'" do
    Factory.build(:vote, :vote => 'FOO').should_not be_valid
  end

end

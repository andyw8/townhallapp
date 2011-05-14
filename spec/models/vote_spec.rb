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

  it "is valid with a vote of 'MINUS'" do
    Factory.build(:vote, :vote => 'MINUS').should be_valid
  end

  it "is invalid with a vote of 'FOO'" do
    Factory.build(:vote, :vote => 'FOO').should_not be_valid
  end

  it "is invalid with repeat vote from the same user" do
    submission = Factory.create(:submission)
    user = Factory.create(:user)
    Factory.create(:vote, :user => user, :submission => submission)
    Factory.build(:vote, :user => user, :submission => submission).should be_invalid
  end

  it "is valid with multiple votes from different users" do
    submission = Factory.create(:submission)
    user = Factory.create(:user)
    another_user = Factory.create(:user)
    Factory.create(:vote, :user => user, :submission => submission)
    Factory.build(:vote, :user => another_user, :submission => submission).should be_valid
  end

end

require 'spec_helper'

describe Vote do

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:submission) }
  it { should validate_presence_of(:vote) }
  it { should belong_to(:submission) }
  it { should belong_to(:user) }

  it "should be valid with a vote of 'PLUS'" do
    Factory.build(:vote, :vote => 'PLUS').should be_valid
  end

  it "should be valid with a vote of 'MINUS'" do
    Factory.build(:vote, :vote => 'MINUS').should be_valid
  end

  it "should be invalid with a vote of 'FOO'" do
    Factory.build(:vote, :vote => 'FOO').should_not be_valid
  end

  # These next two tests hit the database, which isn't ideal
  # for a unit test, but the general consensus seems be that
  # this is the best approach for testing a uniqueness constraint

  it "should be invalid with repeat vote from the same user" do
    submission = Factory.build(:submission)
    user = Factory.build(:user)
    Factory.create(:vote, :user => user, :submission => submission)
    Factory.build(:vote, :user => user, :submission => submission).should be_invalid
  end

  it "should be valid with multiple votes from different users" do
    submission = Factory.build(:submission)
    user = Factory.build(:user)
    Factory.create(:vote, :submission => submission) # vote from another user
    Factory.build(:vote, :user => user, :submission => submission).should be_valid
  end

end

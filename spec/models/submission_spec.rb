require 'spec_helper'

describe Submission do

  it do
    should validate_presence_of(:name)
    should validate_presence_of(:user)
    should validate_presence_of(:series)
    should belong_to :user
    should belong_to :series
  end

  describe "#user_has_voted?" do

    it "should be true if the user has voted on that submission" do
      submission = Factory.create(:submission)
      user = Factory.create(:user)
      Factory.create(:vote, :submission => submission, :user => user)
      submission.user_has_voted?(user).should be_true
    end

    it "should be false if a different user has voted on that submission" do
      submission = Factory.create(:submission)
      user = Factory.create(:user)
      another_user = Factory.create(:user)
      Factory.create(:vote, :submission => submission, :user => another_user)
      submission.user_has_voted?(user).should be_false
    end

    it "should be false if the user hasn't voted on that submission" do
      submission = Factory.create(:submission)
      user = Factory.create(:user)
      submission.user_has_voted?(user).should be_false
    end

  end

end

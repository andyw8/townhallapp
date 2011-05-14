require 'spec_helper'

describe Submission do

  it do
    should validate_presence_of(:name)
    should validate_presence_of(:user)
    should validate_presence_of(:series)
    should validate_presence_of(:score)
    should belong_to :user
    should belong_to :series
  end

  context "submission" do

    before { @submission = Factory.create(:submission) }

    describe "#user_has_voted?" do

      it "should have a default score of 0" do
        @submission.score.should be(0)
      end

      it "should have a score of 2 for two PLUS votes" do
        2.times do
          Factory.create(:vote, :vote => 'PLUS', :submission => @submission)
        end
        @submission.score.should be(2)
      end

      it "should have a score of -2 for two MINUS votes" do
        2.times do
          Factory.create(:vote, :vote => 'MINUS', :submission => @submission)
        end
        @submission.score.should be(-2)
      end

      it "should have a net score of 0 for two PLUS votes and two MINUS votes" do
        2.times do
          Factory.create(:vote, :vote => 'PLUS', :submission => @submission)
          Factory.create(:vote, :vote => 'MINUS', :submission => @submission)
        end
        @submission.score.should be(0)
      end

      it "should be true if the user has voted on that submission" do
        user = Factory.create(:user)
        Factory.create(:vote, :submission => @submission, :user => user)
        @submission.user_has_voted?(user).should be_true
      end

      it "should be false if a different user has voted on that submission" do
        user = Factory.create(:user)
        another_user = Factory.create(:user)
        Factory.create(:vote, :submission => @submission, :user => another_user)
        @submission.user_has_voted?(user).should be_false
      end

      it "should be false if the user hasn't voted on that submission" do
        user = Factory.create(:user)
        @submission.user_has_voted?(user).should be_false
      end

    end

    describe "#allowed_to_vote?" do

      it "should be true if the user is signed in and hasn't already voted" do
        @submission.votes.stub(:find) { nil }
        @submission.allowed_to_vote?(nil, true).should be_true
      end

      it "should be false if the user isn't signed in" do
        @submission.allowed_to_vote?(nil, false).should be_false
      end

      it "should be false if the user has already voted" do
        @submission.votes.stub(:find) { Factory.build(:vote) }
        @submission.allowed_to_vote?(nil, true).should be_false
      end

    end

  end

end

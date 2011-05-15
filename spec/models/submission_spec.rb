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

    let(:submission) { Submission.new }

    describe "#calculate_score" do
      it "should handle positive scores" do
        submission.stub_chain("votes.plus.count").and_return(2)
        submission.stub_chain("votes.minus.count").and_return(1)
        submission.should_receive(:save!)
        submission.update_score
        submission.score.should == 1
      end

      it "should handle negative scores" do
        submission.stub_chain("votes.plus.count").and_return(1)
        submission.stub_chain("votes.minus.count").and_return(2)
        submission.should_receive(:save!)
        submission.update_score
        submission.score.should == -1
      end
    end

    describe "#users" do

      it "should return an empty array for a submission without any votes" do
        submission.users.should be_empty
      end

      it "should return an array of users who voted" do
        user_1, user_2 = User.new, User.new
        vote_1, vote_2 = Vote.new, Vote.new
        vote_1.user, vote_2.user = user_1, user_2
        submission.stub(:votes).and_return([vote_1, vote_2])
        submission.users.should == [user_1, user_2]
      end

    end

    describe "#score" do

      it "should have a default score of 0" do
        submission.score.should be(0)
      end

      it "should have a score of 2 for two PLUS votes" do
        submission.stub_chain("votes.plus.count").and_return(2)
        submission.stub_chain("votes.minus.count").and_return(0)
        submission.should_receive(:save!)
        submission.update_score
        submission.score.should be(2)
      end

      it "should have a score of -2 for two MINUS votes" do
        submission.stub_chain("votes.plus.count").and_return(0)
        submission.stub_chain("votes.minus.count").and_return(2)
        submission.should_receive(:save!)
        submission.update_score
        submission.score.should be(-2)
      end

      it "should have a net score of 0 for two PLUS votes and two MINUS votes" do
        submission.stub_chain("votes.plus.count").and_return(0)
        submission.stub_chain("votes.minus.count").and_return(0)
        submission.should_receive(:save!)
        submission.update_score
        submission.score.should be(0)
      end

    end

    describe "#user_has_voted?" do

      it "should be true if the user has voted on that submission" do
        submission.stub_chain("votes.find").and_return(Vote.new)
        submission.user_has_voted?(User.new).should be_true
      end

      it "should be false if the user hasn't voted on that submission" do

        submission.stub_chain("votes.find").and_return(nil)
        submission.user_has_voted?(User.new).should be_false
      end

    end

    describe "#allowed_to_vote?" do

      it "should be true if the user is signed in and hasn't already voted" do
        submission.votes.stub(:find).and_return(nil)
        submission.allowed_to_vote?(User.new, true).should be_true
      end

      it "should be false if the user isn't signed in" do
        submission.allowed_to_vote?(User.new, false).should be_false
      end

      it "should be false if the user has already voted" do
        submission.votes.stub(:find).and_return(Factory.build(:vote))
        submission.allowed_to_vote?(User.new, true).should be_false
      end

    end

  end

end

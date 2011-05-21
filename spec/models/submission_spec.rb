require 'spec_helper'

describe Submission do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:series) }
  it { should validate_presence_of(:score) }
  it { should belong_to :user }
  it { should belong_to :series }

  let(:submission) { Submission.new }

  describe "#update_score" do

    it "should set the score to 0 when there are no votes" do
      submission.stub_chain("votes.plus.count").and_return(0)
      submission.stub_chain("votes.minus.count").and_return(0)
      submission.should_receive(:save!)
      submission.update_score
      submission.score.should be(0)
    end

    it "should set the score to 1 when there are two PLUS votes and 1 MINUS vote" do
      submission.stub_chain("votes.plus.count").and_return(2)
      submission.stub_chain("votes.minus.count").and_return(1)
      submission.should_receive(:save!)
      submission.update_score
      submission.score.should be(1)
    end

    it "should set the score to -1 when there is one PLUS vote and 2 MINUS votes" do
      submission.stub_chain("votes.plus.count").and_return(1)
      submission.stub_chain("votes.minus.count").and_return(2)
      submission.should_receive(:save!)
      submission.update_score
      submission.score.should be(-1)
    end

    it "should set the score to 0 when there are 2 PLUS votes and 2 MINUS votes" do
      submission.stub_chain("votes.plus.count").and_return(2)
      submission.stub_chain("votes.minus.count").and_return(2)
      submission.should_receive(:save!)
      submission.update_score
      submission.score.should be(0)
    end

  end

  describe "#users" do

    it "should return an empty array when there are no votes" do
      submission.stub(:votes).and_return([])
      submission.users.should be_empty
    end

    it "should return array of unique users who voted when there are votes" do
      user_1 = mock('User')
      user_2 = mock('User')
      vote_1 = mock('Vote', user: user_1)
      vote_2 = mock('Vote', user: user_2)
      submission.stub(:votes).and_return([vote_1, vote_2])
      submission.users.should == [user_1, user_2]
    end

  end

  describe "#user_has_voted?" do

    it "should return true when there is a vote from that user" do
      submission.stub_chain("votes.find_by_user_id").and_return(mock('Vote'))
      submission.user_has_voted?(mock('User')).should be_true
    end

    it "should return false when there are no votes from that user" do
      submission.stub_chain("votes.find_by_user_id").and_return(nil)
      submission.user_has_voted?(mock('User')).should be_false
    end

  end

  describe "#allowed_to_vote?" do

    it "should return true when that user is signed in and hasn't already voted" do
      submission.stub_chain("votes.find_by_user_id").and_return(nil)
      submission.allowed_to_vote?(mock('User'), true).should be_true
    end

    it "should return false when that user isn't signed in" do
      submission.allowed_to_vote?(mock('User'), false).should be_false
    end

    it "should return false when that user has already voted" do
      submission.stub_chain("votes.find_by_user_id").and_return(mock('Vote'))
      submission.allowed_to_vote?(mock('User'), true).should be_false
    end

  end

  describe "#votes" do
    it "returns the number of votes received" do
      submission.stub_chain("votes.count").and_return(5)
      submission.votes_count.should be(5)
    end
  end

  describe "#author" do
    it "returns the number of email address of the submission creator" do
      submission.stub_chain("user.email").and_return('hello@example.com')
      submission.author.should == 'hello@example.com'
    end
  end

  describe "#vote_by_user" do
    it "return the vote (e.g. PLUS or MINUS) of the given user" do
      submission.stub_chain("votes.find_by_user_id").and_return(mock('Vote', vote: 'PLUS'))
      submission.vote_by_user(mock('User')).should == 'PLUS'
    end
  end


end

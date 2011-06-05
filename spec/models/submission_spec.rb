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
      submission.stub_chain(:votes, :plus, :count).and_return(0)
      submission.stub_chain(:votes, :minus, :count).and_return(0)
      submission.should_receive(:save!)
      submission.update_score
      submission.score.should == 0
    end

    it "should set the score by subtracting the MINUS votes from the PLUS votes" do
      submission.stub_chain(:votes, :plus, :count).and_return(2)
      submission.stub_chain(:votes, :minus, :count).and_return(1)
      submission.should_receive(:save!)
      submission.update_score
      submission.score.should == 1
    end

    it "should set a negative score when there are more MINUS votes than PLUS votes" do
      submission.stub_chain(:votes, :plus, :count).and_return(1)
      submission.stub_chain(:votes, :minus, :count).and_return(2)
      submission.should_receive(:save!)
      submission.update_score
      submission.score.should == -1
    end

    it "should set the score to 0 when there are equal plus and minus votes" do
      submission.stub_chain(:votes, :plus, :count).and_return(2)
      submission.stub_chain(:votes, :minus, :count).and_return(2)
      submission.should_receive(:save!)
      submission.update_score
      submission.score.should == 0
    end

  end

  describe "#user_has_voted?" do

    it "should return true when there is a vote from that user" do
      submission.stub_chain(:all_votes, :find_by_user_id).and_return(mock('Vote'))
      submission.user_has_voted?(mock('User')).should be_true
    end

    it "should return false when there are no votes from that user" do
      submission.stub_chain(:all_votes, :find_by_user_id).and_return(nil)
      submission.user_has_voted?(mock('User')).should be_false
    end

  end

  describe "#allowed_to_vote?" do

    it "should return true when that user is signed in and hasn't already voted" do
      submission.stub_chain(:all_votes, :find_by_user_id).and_return(nil)
      submission.allowed_to_vote?(mock('User'), true).should be_true
    end

    it "should return false when that user isn't signed in" do
      submission.allowed_to_vote?(mock('User'), false).should be_false
    end

    it "should return false when that user has already voted" do
      submission.stub_chain(:all_votes, :find_by_user_id).and_return(mock('Vote'))
      submission.allowed_to_vote?(mock('User'), true).should be_false
    end

  end

  describe "#author" do
    it "returns the number of email address of the submission creator" do
      submission.stub_chain(:user, :email).and_return('hello@example.com')
      submission.author.should == 'hello@example.com'
    end
  end

  describe "#vote_by_user" do
    it "returns the vote (e.g. PLUS or MINUS) of the given user" do
      submission.stub_chain(:all_votes, :find_by_user_id).and_return(mock('Vote', vote: 'PLUS'))
      submission.vote_by_user(mock('User')).should == 'PLUS'
    end
  end

  describe "#comments_count" do
    it "returns the number of comments on the submission" do
      submission.stub_chain(:comments, :count).and_return(3)
      submission.comments_count.should == 3
    end
  end

end

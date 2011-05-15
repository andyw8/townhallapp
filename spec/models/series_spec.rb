require 'spec_helper'

describe Series do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should belong_to :user }
  it { should have_many(:submissions) }

  let(:series) { Series.new }

  describe "#votes_count" do

    it "should be 0 when there are no submissions" do
      series.stub_chain(:submissions).and_return([])
      series.votes_count.should be(0)
    end

    it "should count the votes when there are multiple submissions" do
      submission_1 = mock_model('Submission', :votes_count => 2)
      submission_2 = mock_model('Submission', :votes_count => 3)
      series.stub(:submissions) { [submission_1, submission_2]}
      series.votes_count.should be(5)
    end

  end

  describe "#users_count" do

    it "should be 0 when there are no submissions" do
      series.stub(:submissions).and_return([])
      series.users_count.should be(0)
    end

    it "should determine how many unique users have participated it's submissions" do
      u1, u2, u3 = mock_model('User'), mock_model('User'), mock_model('User')
      submission_1 = stub_model(Submission, :users => [u1, u2])
      submission_2 = stub_model(Submission, :users => [u2, u3])
      series.stub(:submissions) { [submission_1, submission_2] }
      series.users_count.should be(3)
    end

  end

  describe "#submissions_count" do

    it "should be 0 when there are no submissions" do
      series.stub(:submissions).and_return([])
      series.submissions_count.should be(0)
    end

    it "should count the number of submissions" do
      series.stub_chain("submissions.count").and_return(3)
      series.submissions_count.should be(3)
    end
  end

end

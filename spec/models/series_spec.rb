require 'spec_helper'

describe Series do

  it do
    should validate_presence_of(:name)
    should validate_presence_of(:user)
    should belong_to :user
  end

  context "series" do

    let(:series) { Factory.create(:series) }

    describe "#votes_count" do

      it "is 0 for a new series" do
        series.votes_count.should be(0)
      end

      it "calculates the total votes" do
        submission_1 = mock_model('Submission', :votes_count => 2)
        submission_2 = mock_model('Submission', :votes_count => 3)
        series.stub(:submissions) { [submission_1, submission_2]}
        series.votes_count.should be(5)
      end

    end

    describe "#users_count" do

      it "is 0 for a new series" do
        series.users_count.should be(0)
      end

      it "count the number of unique users who have partipated in it's submissions" do
        u1 = mock_model('User')
        u2 = mock_model('User')
        u3 = mock_model('User')
        submission_1 = stub_model(Submission, :users => [u1, u2])
        submission_2 = stub_model(Submission, :users => [u2, u3])
        series.stub(:submissions) { [submission_1, submission_2] }
        series.users_count.should be(3)
      end

    end

    describe "#submissions_count" do
      it "is 0 for a new series" do
        series.submissions_count.should be(0)
      end

      it "counts the number of submissions" do
        series.stub(:submissions) { stub_model(Array, :count => 3) }
        series.submissions_count.should be(3)
      end
    end
  end

end

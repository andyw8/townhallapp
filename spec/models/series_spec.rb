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
      series.votes_count.should == 0
    end

    it "should count the votes when there are multiple submissions" do
      submission_1 = mock('', votes_count: 2)
      submission_2 = mock('', votes_count: 3)
      series.stub(:submissions) { [submission_1, submission_2]}
      series.votes_count.should == 5
    end

  end

  describe "#users_count" do

    it "should be 0 when there are no submissions" do
      series.stub(:submissions).and_return([])
      series.users_count.should == 0
    end

    it "should determine how many unique users have participated it's submissions" do
      u1, u2, u3 = mock(), mock(), mock()
      submission_1 = mock('', users: [u1, u2])
      submission_2 = mock('', users: [u2, u3])
      series.stub(:submissions).and_return([submission_1, submission_2])
      series.users_count.should == 3
    end

  end

  describe "#submissions_count" do

    it "should be 0 when there are no submissions" do
      series.stub(:submissions).and_return([])
      series.submissions_count.should == 0
    end

    it "should count the number of submissions" do
      series.stub_chain("submissions.count").and_return(3)
      series.submissions_count.should == 3
    end
  end

  describe "#new_submission" do

    it "should initantiate a new submission using the given user if supplied" do
      bob = mock_model('User')
      submission = series.new_submission(nil, bob)
      submission.user.should be(bob)
    end

    it "should initantiate a new submission assigned to no-one if not supplied" do
      submission = series.new_submission
      submission.user.should be_nil
    end

    it "should initantiate a new submission with the provided attributes" do
      submission = series.new_submission({'name' => 'foo'})
      submission.name.should == 'foo'
    end

    it "instantiates a new submission with no attributes if not supplied" do
      submission = series.new_submission
      submission.name.should be_nil
    end

  end

  describe "#featured_submission" do

    it "should return nil if there are no submissions" do
      # need something here
      series.featured_submission.should be_nil
    end

    it "should return the only submission if there is only one" do
      submission_1 = mock('submission')
      series.stub(:submissions).and_return([submission_1])
      series.featured_submission.should be(submission_1)
    end

    it "should return a random submission" do
      submission_0, submission_1, submission_2 = mock('s1'), mock('s2'), mock('s3')
      series.stub(:submissions).and_return([submission_0, submission_1, submission_2])
      series.random_generator = mock('random_generator', :get_value => 2)
      series.featured_submission.should be(submission_2)
    end

  end

  describe "#submissions_not_yet_voted_on" do
    it "should return an empty array if there are no submissions" do
      series.stub(:submissions).and_return([])
      user = mock('user')
      series.submissions_not_yet_voted_on(user).should be_empty
    end

    it "should return all submissions if none have been voted on" do
      s0, s1, s2 = stub('s0'), stub('s1'), stub('s2')
      submissions = [s0, s1, s2]
      series.stub(:submissions).and_return(submissions)
      user = mock('user')
      series.submissions_not_yet_voted_on(user).should == submissions
    end

    # it "should return all submissions excluding those the user has voted on" do
    #   submission_0, submission_1, submission_2 = stub('s1'), stub('s2'), stub('s3')
    #   user = mock('user')
    #   submission_0.expect(:user_has_voted?).with(user).and_return(false)
    #   submission_1.expect(:user_has_voted?).with(user).and_return(true)
    #   submission_2.expect(:user_has_voted?).with(user).and_return(false)
    #   series.stub(:submissions).and_return([submission_0, submission_1, submission_2])
    #   series.submissions_not_yet_voted_on(user).should == [submission_0, submission_2]
    # end
  end

end

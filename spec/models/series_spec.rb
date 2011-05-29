require 'spec_helper'

describe Series do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should belong_to :user }
  it { should have_many(:submissions) }

  let(:series) { Series.new }

  describe "#votes_count" do

    it "should return the number of votes" do
      series.stub_chain(:votes, :count).and_return(3)
      series.votes_count.should == 3
    end

  end

  describe "#users_count" do

    it "should return the number of associated users" do
      series.stub_chain(:users, :count).and_return(3)
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
      series.stub_chain(:submissions).and_return([])
      series.featured_submission(stub('user')).should be_nil
    end

    it "should return the submission if there is only one" do
      submission_1 = mock('submission', :user_has_voted? => false)
      series.stub(:submissions).and_return([submission_1])
      series.random_element_picker = mock('', :random_element => submission_1)
      series.featured_submission(stub('user')).should be(submission_1)
    end

    it "should return a random submission from those not yet voted on by the user" do
      s0 = mock('s0', :user_has_voted? => false)
      s1 = mock('s1', :user_has_voted? => true)
      s2 = mock('s2', :user_has_voted? => false)
      series.stub(:submissions).and_return([s0, s1, s2])
      random_element_picker = mock('random_element_picker')
      random_element_picker.should_receive(:random_element).with([s0, s2]).and_return(s0)
      series.random_element_picker = random_element_picker
      series.featured_submission(stub('user'))
    end

  end

end

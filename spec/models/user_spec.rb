require 'spec_helper'

describe User do

  it { should have_many(:series) }

  describe "#new_series" do

    let(:user) { User.new }

    it "instantiates a new user using the supplied attributes" do
      series = user.new_series({'name' => 'foo'})
      series.name.should == 'foo'
    end

  end

end

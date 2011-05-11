require 'spec_helper'

describe Submission do

  it do
    should validate_presence_of(:name)
    should validate_presence_of(:user)
    should validate_presence_of(:series)
    should belong_to :user
    should belong_to :series
  end

end

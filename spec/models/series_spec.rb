require 'spec_helper'

describe Series do

  it do
    should validate_presence_of(:name)
    should validate_presence_of(:user)
    should belong_to :user
  end

end

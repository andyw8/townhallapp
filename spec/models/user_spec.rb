require 'spec_helper'

describe User do

  it do
    should have_many(:series)
  end

end

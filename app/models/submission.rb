class Submission < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name, :user, :series

  belongs_to :series
  belongs_to :user

end

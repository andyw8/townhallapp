class Submission < ActiveRecord::Base

  default_scope :order => 'created_at DESC'

  attr_accessible :name

  validates_presence_of :name, :user, :series

  belongs_to :series
  belongs_to :user

  has_many :votes

end

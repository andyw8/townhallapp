class Submission < ActiveRecord::Base

  default_scope :order => 'created_at DESC'

  attr_accessible :name

  validates_presence_of :name, :user, :series

  belongs_to :series
  belongs_to :user

  has_many :votes

  def user_has_voted?(user)
    votes.find(:first, :conditions => {:user_id => user}).present?
  end

  def allowed_to_vote?(user, user_signed_in)
    user_signed_in && !user_has_voted?(user)
  end

end

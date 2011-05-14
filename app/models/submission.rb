class Submission < ActiveRecord::Base

  default_scope :order => 'score DESC'

  attr_accessible :name

  validates_presence_of :name, :user, :series, :score

  belongs_to :series
  belongs_to :user

  has_many :votes

  def user_has_voted?(user)
    votes.find(:first, :conditions => {:user_id => user}).present?
  end

  def allowed_to_vote?(user, user_signed_in)
    user_signed_in && !user_has_voted?(user)
  end

  def update_score
    #update_attributes(:score, calculate_score)
    self[:score] = calculate_score
    save!
  end

  private

  def calculate_score
    votes.plus.count - votes.minus.count
  end

end

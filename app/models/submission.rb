class Submission < ActiveRecord::Base

  default_scope order: 'score DESC'

  attr_accessible :name

  validates_presence_of :name, :user, :series, :score

  belongs_to :series
  belongs_to :user

  has_many :votes, :conditions => "vote IN ('PLUS', 'MINUS')"
  has_many :all_votes, :class_name => 'Vote'
  has_many :users, :through => :votes, :uniq => true

  def vote_by_user(user)
    vote_from_user(user).vote
  end

  def user_has_voted?(user)
    vote_from_user(user).present?
  end

  def allowed_to_vote?(user, user_signed_in)
    user_signed_in && !user_has_voted?(user)
  end

  def update_score
    self[:score] = plus_votes - minus_votes
    save!
  end

  # plus_votes and minus_vote should probably use has_many with a scope

  def plus_votes
    votes.plus.count
  end

  def minus_votes
    votes.minus.count
  end

  def author
    user.email
  end

  def votes_count
    votes.count
  end

  def new_vote(vote)
    # should this method really be in Vote ?
    votes.new(vote: vote)
  end

  private

  def vote_from_user(user)
    all_votes.find_by_user_id(user)
  end

end

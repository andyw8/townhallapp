class Vote < ActiveRecord::Base

  validates_presence_of :vote, :user, :submission
  validates_inclusion_of :vote, :in => ['PLUS']

  validates_uniqueness_of :user_id, :scope => [:submission_id]

  belongs_to :user
  belongs_to :submission

end

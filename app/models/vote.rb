class Vote < ActiveRecord::Base

  SUCCESS_MESSAGE = "Your vote was recorded"

  attr_accessible :vote

  validates_presence_of :vote, :user, :submission
  validates_inclusion_of :vote, :in => ['PLUS', 'MINUS', 'NONE']

  validates_uniqueness_of :user_id, :scope => [:submission_id]

  belongs_to :user
  belongs_to :submission

  scope :plus, :conditions => "vote = 'PLUS'"
  scope :minus, :conditions => "vote = 'MINUS'"
  scope :skipped, :conditions => "vote = 'NONE'"

  after_save { |vote| vote.submission.update_score }

end

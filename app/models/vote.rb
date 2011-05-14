class Vote < ActiveRecord::Base

  validates_presence_of :vote, :user, :submission
  validates_inclusion_of :vote, :in => ['PLUS']

  belongs_to :user
  belongs_to :submission

end

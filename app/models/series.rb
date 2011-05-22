class Series < ActiveRecord::Base

  default_scope order: 'created_at DESC'

  attr_accessible :name

  validates_presence_of :name, :user

  belongs_to :user
  has_many :submissions

  def votes_count
    total = 0
    submissions.each do |s|
      total += s.votes_count
    end
    total
  end

  def users_count
    users = []
    submissions.each do |s|
      # seems that += isn't permitted on an array
      users = users + s.users
    end
    users.uniq.size
  end

  def submissions_count
    submissions.count
  end

  # should this method really be in Submission ?
  def new_submission(attributes={}, current_user=nil)
    submission = submissions.new(attributes)
    submission.user = current_user
    submission
  end

end

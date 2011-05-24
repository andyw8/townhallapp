class Series < ActiveRecord::Base

  attr_accessible :name
  attr_writer :random_element_picker

  default_scope order: 'created_at DESC'

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
    submissions.each { |s| users += s.users }
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

  def featured_submission(user)
    avail = submissions_not_yet_voted_on(user)
    avail.any? ? @random_element_picker.random_element(avail) : nil
  end

  def submissions_not_yet_voted_on(user)
    # this should probably be done as a database query
    submissions.reject { |s| s.user_has_voted?(user) }
  end

end

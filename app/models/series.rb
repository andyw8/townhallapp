class Series < ActiveRecord::Base

  attr_accessible :name
  attr_writer :random_element_picker

  default_scope order: 'created_at DESC'

  validates_presence_of :name, :user

  belongs_to :user
  has_many :submissions
  has_many :users, :through => :submissions, :uniq => true

  def votes_count
    submissions.inject(0) { |total, submission| total += submission.votes_count }
  end

  def users_count
    users.count
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
    submissions_eligible_to_vote_on = submissions_not_yet_voted_on(user)
    if submissions_eligible_to_vote_on.any?
      random_element_picker.random_element(submissions_eligible_to_vote_on)
    else
      nil
    end
  end

  private

  def submissions_not_yet_voted_on(user)
    # this should probably be done as a database query
    submissions.reject { |s| s.user_has_voted?(user) }
  end

  def random_element_picker
    @random_element_picker ||= RandomElementPicker.new
  end

end

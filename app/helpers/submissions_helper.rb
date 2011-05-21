module SubmissionsHelper

  def vote_buttons(submission)
    (button_to 'Vote For', {controller: :votes, action: :create, series_id: submission.series, submission_id: submission, vote: 'PLUS'}) + (button_to 'Vote Against', {controller: :votes, action: :create, series_id: submission.series, submission_id: submission, vote: 'MINUS'})
  end

  def vote_review(submission)
    if submission.vote_by_user(current_user) == 'PLUS'
      "You voted for this"
    elsif submission.vote_by_user(current_user) == 'MINUS'
      "You voted against this"
    else
      raise "Invalid vote value"
    end
  end

end

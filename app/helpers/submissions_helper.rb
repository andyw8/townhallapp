module SubmissionsHelper

  def vote_button(submission)
    button_to 'Vote', {:controller => :votes, :action => :create, :series_id => submission.series, :submission_id => submission}
  end

end

module SubmissionsHelper

  def vote_buttons(submission)
    (button_to 'Vote For', {:controller => :votes, :action => :create, :series_id => submission.series, :submission_id => submission, :vote => 'PLUS'}) + (button_to 'Vote Against', {:controller => :votes, :action => :create, :series_id => submission.series, :submission_id => submission, :vote => 'MINUS'})
  end

end

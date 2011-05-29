module SubmissionsHelper

  def vote_buttons(submission)
    buttons = {'Vote For' => 'PLUS', 'Vote Against' => 'MINUS', 'Skip' => 'NONE'}
    result = []
    buttons.each_pair do |title, value|
      result << (button_to title,
        {controller: :votes, action: :create, series_id: submission.series,
          submission_id: submission, vote: value})
    end
    result.join
  end

  def vote_review(submission)
    case submission.vote_by_user(current_user)
    when 'PLUS'
      "You voted for this"
    when 'MINUS'
      "You voted against this"
    when 'NONE'
      "You skipped this"
    end

  end

end

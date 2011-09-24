class VotesController < ApplicationController

  before_filter :authenticate_user!

  def create
    vote = submission.new_vote(params[:vote])
    vote.user = current_user
    vote.save!
    redirect_to series_url(submission.series), :notice => "Your vote was recorded"
  end

  private

  def submission
    @submission ||= Submission.find(params[:submission_id])
  end

end

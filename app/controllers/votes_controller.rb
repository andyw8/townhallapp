class VotesController < ApplicationController

  before_filter :authenticate_user!

  def create
    vote = submission.record_vote(params[:vote], current_user)
    redirect_to series_url(submission.series), :notice => Vote::SUCCESS_MESSAGE
  end

  private

  def submission
    @submission ||= Submission.find(params[:submission_id])
  end

end

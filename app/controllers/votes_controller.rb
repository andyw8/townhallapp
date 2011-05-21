class VotesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_submission

  def create
    vote = @submission.votes.new(vote: params[:vote])
    vote.user = current_user
    vote.save!
    redirect_to series_url(@submission.series), notice: "Your vote was recorded"
  end

  private

  def find_submission
    @submission = Submission.find(params[:submission_id])
  end

end

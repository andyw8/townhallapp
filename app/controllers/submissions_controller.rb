class SubmissionsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @submission = series.new_submission
  end

  def create
    @submission = series.new_submission(params[:submission], current_user)
    if @submission.save
      redirect_to series_url(series), :notice => "Successfully created submission."
    else
      render :action => 'new'
    end
  end

  private

  def series
    @series ||= Series.find(params[:series_id])
  end

end

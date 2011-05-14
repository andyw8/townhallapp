class SubmissionsController < ApplicationController

  before_filter :find_series

  def index
    @submissions = @series.submissions.all
  end

  def new
    @submission = @series.submissions.new
  end

  def create
    @submission = @series.submissions.new(params[:submission])
    @submission.user = current_user
    if @submission.save
      redirect_to series_url(@series), :notice => "Successfully created submission."
    else
      render :action => 'new'
    end
  end

  private

  def find_series
    @series = Series.find(params[:series_id])
  end

end

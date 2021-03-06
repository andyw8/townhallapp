class SeriesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def new
    @series = Series.new
  end

  def create
    @series = current_user.new_series(params[:series])
    if @series.save
      redirect_to series_index_path, :notice => "Successfully created series."
    else
      render :action => 'new'
    end
  end

  def index
    @series = Series.all
  end

  def show
    @series = Series.find(params[:id])
    @featured_submission = @series.featured_submission(current_user)
  end
end

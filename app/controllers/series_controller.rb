class SeriesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index]

  def new
    @series = Series.new
  end

  def create
    @series = current_user.series.new(params[:series])
    if @series.save
      redirect_to series_index_path, :notice => "Successfully created series."
    else
      render :action => 'new'
    end
  end

  def index
    @series = Series.all
  end
end

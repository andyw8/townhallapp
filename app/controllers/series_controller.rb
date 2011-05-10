class SeriesController < ApplicationController
  def new
    @series = Series.new
  end

  def create
    @series = Series.new(params[:series])
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

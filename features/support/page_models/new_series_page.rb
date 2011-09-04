module PageModel
  class NewSeriesPage < PageModel::Base

  end
end

def new_series_page
  PageModel::NewSeriesPage.new
end

World(PageModel)

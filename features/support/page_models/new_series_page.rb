module PageModel
  class NewSeriesPage < PageModel::Base
    
    def visit(series)
      session.visit visit new_series_path
    end
  
  end
end

def new_series_page
  PageModel::NewSeriesPage.new
end
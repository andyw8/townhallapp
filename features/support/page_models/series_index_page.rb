module PageModel
  class SeriesIndexPage < PageModel::Base

    def visit
      session.visit series_index_path
    end

    def series_count
      session.all('#series li').size
    end
  
  end
end

def series_index_page
  PageModel::SeriesIndexPage.new
end

#World(PageModel)

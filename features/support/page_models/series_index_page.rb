module PageModel
  class SeriesIndexPage < PageModel::Base

    def verify_series_count(count)
      session.all('#series li').size.should == count
    end
  
  end
end

def series_index_page
  PageModel::SeriesIndexPage.new
end

World(PageModel)

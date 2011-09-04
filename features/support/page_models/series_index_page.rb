module PageModel
  class SeriesIndexPage < PageModel::Base
    
    def visit
      @session.visit series_index_path
    end

    def verify_series_count(count)
      session.all('#series li').size.should == count
    end
  
  end
end

World(PageModel)
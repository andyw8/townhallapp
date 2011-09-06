module Page
  module Series
    class Index < Page::Base

      def visit
        session.visit series_index_path
      end

      def series_count
        session.all('#series li').size
      end
  
    end
  end
end

def series_index_page
  Page::Series::Index.new
end

#World(PageModel)

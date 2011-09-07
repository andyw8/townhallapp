module Page
  module Series
    class Index < Page::Base

      def visit
        session.visit series_index_path
      end

      def series_count
        session.all('#series li').size
      end
  
      def series_names
        # #series h1 ?
        all('h1').collect(&:text)
      end
      
      def get_series(series)
        prefix = "#series-#{series.id}"
        {
          'users'       => session.find(prefix + ' .users       .value').text,
          'votes'       => session.find(prefix + ' .votes       .value').text,
          'submissions' => session.find(prefix + ' .submissions .value').text
        }
      end
  
    end
  end
end

def series_index_page
  Page::Series::Index.new
end

#World(PageModel)

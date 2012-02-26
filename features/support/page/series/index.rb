module Page
  module Series
    class Index < Page::Base

      def path
        series_index_path
      end

      def series_count
        all('#series li').size
      end

      def series_names
        all_series.keys
      end
    
      def series_list
        Component::SeriesList.new(find('#series')).contents
      end

    end
  end
end

def series_index_page
  Page::Series::Index.new
end

#World(PageModel)

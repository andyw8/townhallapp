module Page
  module Series
    class Index < Page::Base
      def series_count
        series_list.contents.size
      end

      def series_names
        series_list.contents.keys
      end
    
      def series_list_contents
        series_list.contents
      end
      
      private
      
      def series_list
        @series_list = Component::SeriesList.new('#series')
      end

    end
  end
end

def series_index_page
  Page::Series::Index.new
end

#World(PageModel)

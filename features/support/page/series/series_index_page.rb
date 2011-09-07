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
        session.all('#series li a').collect(&:text)
      end
      
      def all_series
        result = {}
        session.all('#series li').each do |s|
          series_name = s.find('a').text
          result[series_name] = {
            'users'       => s.find('.users       .value').text.to_i,
            'votes'       => s.find('.votes       .value').text.to_i,
            'submissions' => s.find('.submissions .value').text.to_i
          }
        end
        result
      end
  
    end
  end
end

def series_index_page
  Page::Series::Index.new
end

#World(PageModel)

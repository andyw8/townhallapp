module SeriesPage
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
    
    def all_series
      result = {}
      all('#series li').each do |element|
        series_name = element.find('a').text
        result[series_name] = {
          'users'       => element.find('.users       .value').text.to_i,
          'votes'       => element.find('.votes       .value').text.to_i,
          'submissions' => element.find('.submissions .value').text.to_i
        }
      end
      result
    end

  end
end

def series_index_page
  SeriesPage::Index.new
end

#World(PageModel)

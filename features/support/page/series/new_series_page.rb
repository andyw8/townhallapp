module Page
  module Series
    class New < Page::Base

      def visit
        session.visit new_series_path
      end

    end
  end
end

def new_series_page
  Page::Series::New.new
end

#World(PageModel)

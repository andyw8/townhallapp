module Page
  module Series
    class New < Page::Base

      def visit
        Capybara.current_session.visit new_series_path
      end
      
      def create(name)
        visit
        fill_in :name, :with => name
        click_button 'Create Series'
        should have_content('Successfully created series')
      end

    end
  end
end

def new_series_page
  Page::Series::New.new
end

#World(PageModel)

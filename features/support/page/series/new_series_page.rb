module SeriesPage
  class New < Page::Base

    def path
      new_series_path
    end
    
    def create(name)
      visit
      fill_in :name, :with => name
      click_button 'Create Series'
      should have_content('Successfully created series')
    end

  end
end

def new_series_page
  SeriesPage::New.new
end

#World(PageModel)

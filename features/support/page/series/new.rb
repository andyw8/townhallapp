module Page
  class New < Page::Base

    def path
      new_series_path
    end
    
    def create(name)
      visit
      fill_in :name, :with => name
      click_button 'Create Series'
    end

  end
end

def new_series_page
  Page::New.new
end

#World(PageModel)

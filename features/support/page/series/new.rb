module Page
  class New < Page::Base
    def create(name)
      fill_in :name, :with => name
      click_button 'Create Series'
    end

  end
end

def new_series_page
  Page::New.new
end

#World(PageModel)

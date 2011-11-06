module NewSubmissionPage
  class New < Page::Base
    
    def create(name)
      fill_in :name, :with => name
      click_button 'Create Submission'
    end

  end
end

def new_submission_page
  NewSubmissionPage::New.new
end

#World(PageModel)

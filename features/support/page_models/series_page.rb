module PageModel
  class SeriesPage
    
    def initialize(page)
      @page = page
    end

    def has_featured_submission?
      @page.has_css?('#featured-submission')
    end

    def feature_submission_name
      @page.find('#featured-submission .name').text
    end

    def has_all_voted_on_message?
      @page.has_css?('.all-voted-on')
    end
  
    def click_button_for_submission(button_label, submission)
      submission = Submission.find_by_name(submission_name)
      within("#submission-#{submission.id}") do
        click_button button_label
      end
    end
  
  end
end

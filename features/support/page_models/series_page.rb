module PageModel
  class SeriesPage < PageModel::Base
    
    def visit(series)
      session.visit series_path(series)
    end

    def has_featured_submission?
      session.has_css?('#featured-submission')
    end

    def feature_submission_name
      session.find('#featured-submission .name').text
    end

    def has_all_voted_on_message?
      session.has_css?('.all-voted-on')
    end
  
    def click_button_for_submission(button_label, submission_name)
      submission = Submission.find_by_name(submission_name)
      session.within("#submission-#{submission.id}") do
        session.click_button button_label
      end
    end
    
    def vote_buttons
      session.all('input[value="Vote"]')
    end
    
    def vote_review_text(submission)
      session.find("#submission-#{submission.id} .vote-review").text.strip
    end
    
    def plus_vote_count(submission)
      session.within("#submission-#{submission.id}") do
        session.find('.plus .value').text.to_i
      end
    end

    def minus_vote_count(submission)
      session.within("#submission-#{submission.id}") do
        session.find('.minus .value').text.to_i
      end 
    end
    
    def has_vote_review?(submission)
      session.has_css?("#submission-#{submission.id} .vote-review")
    end

    def has_vote_button?(submission)
      session.has_css?("#submission-#{submission.id} input[value='Vote']")
    end
  
  end
end

def series_page
  PageModel::SeriesPage.new
end
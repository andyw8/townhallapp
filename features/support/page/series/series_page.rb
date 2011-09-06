module Page
  module Series
    class Show < Page::Base

      def visit(series)
        session.visit series_path(series)
      end

      def has_featured_submission?
        session.has_css?(featured_submission_sel)
      end

      def feature_submission_name
        session.find("#{featured_submission_sel} .name").text
      end

      def has_all_voted_on_message?
        session.has_css?('.all-voted-on')
      end
  
      def click_button_for_submission(button_label, submission_name)
        submission = Submission.find_by_name(submission_name)
        session.within(submission_sel(submission)) do
          session.click_button button_label
        end
      end
    
      def vote_buttons
        session.all('input[value="Vote"]')
      end
    
      def vote_review_text(submission)
        session.find("#{submission_sel(submission)} .vote-review").text.strip
      end
    
      def plus_vote_count(submission)
        session.within(submission_sel(submission)) do
          session.find('.plus .value').text.to_i
        end
      end

      def minus_vote_count(submission)
        session.within(submission_sel(submission)) do
          session.find('.minus .value').text.to_i
        end 
      end
    
      def has_vote_review?(submission)
        session.has_css?("#{submission_sel(submission)} .vote-review")
      end

      def has_vote_button?(submission)
        session.has_css?("#{submission_sel(submission)} input[value='Vote']")
      end
      
      def submissions_count
        session.all('#submissions li').size
      end
      
      def submission_author_email(submission)
        session.find("#{submission_sel(submission)} .author-name").text
      end
      
      def submission_names
        session.all('#submissions .name').collect(&:text)
      end
      
      def follow_new_submission
        session.click_link "New Submission"
      end
      
      private
            
      def submission_sel(submission)
        "#submission-#{submission.id}"
      end
      
      def featured_submission_sel
        '#featured-submission'
      end
        
    end
  end
end

def series_page
  Page::Series::Show.new
end

#World(PageModel)

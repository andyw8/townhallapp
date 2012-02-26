module Page
  module Series
    class Show < Page::Base

      def path(series)
        series_path(series)
      end
    
      def new_submission
        click_link 'New Submission'
      end

      def has_featured_submission?
        has_css?(featured_submission_sel)
      end

      def feature_submission_name
        find("#{featured_submission_sel} .name").text
      end

      def has_all_voted_on_message?
        has_css?('.all-voted-on')
      end

      def click_button_for_submission(button_label, submission_name)
        submission = ::Submission.find_by_name(submission_name)
        session.within(submission_sel(submission)) do
          session.click_button button_label
        end
      end
  
      def vote_buttons
        all('input[value="Vote"]')
      end
  
      def vote_review_text(submission)
        find("#{submission_sel(submission)} .vote-review").text.strip
      end
  
      def plus_vote_count(submission)
        session.within(submission_sel(submission)) do
          find('.plus .value').text.to_i
        end
      end

      def minus_vote_count(submission)
        session.within(submission_sel(submission)) do
          find('.minus .value').text.to_i
        end 
      end
  
      def has_vote_review?(submission)
        has_css?("#{submission_sel(submission)} .vote-review")
      end

      def has_vote_button?(submission)
        has_css?("#{submission_sel(submission)} input[value='Vote']")
      end
    
      def submissions_count
        all('#submissions li').size
      end
    
      def submission_author_email(submission)
        find("#{submission_sel(submission)} .author-name").text
      end
    
      def submission_names
        all('#submissions .name').collect(&:text)
      end
    
      def follow_new_submission
        click_link "New Submission"
      end
    
      def vote_on_submission(submission, position)
        session.within("#submission-#{submission.id}") do
          click_button "Vote #{position.titleize}"
        end
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

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
        featured_submission.present?
      end

      def feature_submission_name
        featured_submission.name
      end

      def has_all_voted_on_message?
        featured_submission.voted_on?
      end

      def click_button_for_submission(button_label, submission_name)
        submissions_list.submissions[submission_name][:buttons][button_label].click
      end
  
      def vote_buttons
        all('input[value="Vote"]')
      end
  
      def vote_review_text(submission)
        submissions_list.submissions[submission.name][:vote_review]
      end
  
      def plus_vote_count(submission)
        submissions_list.submissions[submission.name][:plus_votes]
      end

      def minus_vote_count(submission)
        submissions_list.submissions[submission.name][:minus_votes]
      end
  
      def has_vote_review?(submission)
        !submissions_list.submissions[submission.name][:vote_review].nil?
      end

      def has_vote_button?(submission)
        submissions_list.submissions[submission.name][:has_vote_button]
      end
    
      def submissions_count
        submissions_list.submissions_count
      end
    
      def submission_author_email(submission)
        submissions_list.submissions[submission.name][:author_name]
      end
    
      def submission_names
        submissions_list.names
      end
    
      def follow_new_submission
        click_link "New Submission"
      end
    
      def vote_on_submission(submission, position)
        session.within("#submission-#{submission.id}") do
          click_button "Vote #{position.titleize}"
        end
      end
      
      def has_submissions?
        submissions_list.present?
      end
    
      private
      
      def featured_submission
        @featured_submission ||= Component::FeaturedSubmission.new('#featured-submission')
      end
      
      def submissions_list
        @submissions_list ||= Component::SubmissionsList.new('#submissions')
      end

    end
  end
end

def series_page
  Page::Series::Show.new
end

#World(PageModel)

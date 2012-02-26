module Component
  class SubmissionsList < Component::Base
    def submissions_count
      root.all('li').size
    end
    
    def names
      root.all('.name').collect(&:text)
    end
    
    def submissions
      r = {}
      root.all('li').each do |li|
        sli = SubmissionListItem.new(li)
        name = sli.name
        r[name] = {
          :plus_votes => sli.plus_votes,
          :minus_votes => sli.minus_votes,
          :vote_review => sli.vote_review,
          :author_name => sli.author_name,
          :has_vote_button => sli.has_vote_button?,
          :buttons => sli.buttons
          }
      end
      r
    end
    
  end
end

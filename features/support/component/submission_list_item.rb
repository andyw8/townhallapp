module Component
  class SubmissionListItem < Component::Base
    
    def initialize(root)
      @root = root
    end
    
    def name
      root.find('.name').text
    end
    
    def plus_votes
      root.find('.plus .value').text.to_i
    end
    
    def minus_votes
      root.find('.minus .value').text.to_i
    end
    
    def author_name
      root.find('.author-name').text
    end
    
    def buttons
      r = {}
      root.all('input').each do |input|
        r[input['value']] = input
      end
      r
    end
    
    def has_vote_button?
      root.has_css?("input[value='Vote']")
    end
    
    def vote_review
      sel = '.vote-review'
      root.find(sel).text.strip if root.has_css?(sel)
    end
    
  end
end

module Component
  class SubmissionsList < Component::Base
    def count
      submissions.size
    end
    
    def names
      submissions.keys
    end
    
    def submissions
      r = {}
      root.all('li').each do |li|
        sli = SubmissionListItem.new(li)
        r[sli.name] = sli
      end
      r
    end
    
  end
end

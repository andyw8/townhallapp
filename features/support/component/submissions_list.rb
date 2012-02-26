module Component
  class SubmissionsList < Component::Base
    def submissions_count
      root.all('li').size
    end
  end
end

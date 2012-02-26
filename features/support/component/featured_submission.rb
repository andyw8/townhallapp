module Component
  class FeaturedSubmission < Component::Base
    def name
      root.find('.name').text
    end
    
    def submissions_count
      root.all('li').size
    end
    
    def author_name
      root.find(".author-name").text
    end
    
    def voted_on?
      root.has_css?('.all-voted-on')
    end
  end
end

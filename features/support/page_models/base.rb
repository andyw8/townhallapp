module PageModel
  class Base
    
    def session
      @session ||= Capybara.current_session
    end
  
    def page_title
      @session.find('h1').text
    end

    def window_title
      @session.find('title').text
    end
  
  end
end

World(PageModel)


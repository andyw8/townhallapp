module Page
  class Base
    
    include Rails.application.routes.url_helpers
  
    def page_title
      session.find('h1').text
    end

    def window_title
      session.find('title').text
    end
    
    private
    
    def session
      @session ||= Capybara.current_session
    end

  end
end

#World(PageModel)

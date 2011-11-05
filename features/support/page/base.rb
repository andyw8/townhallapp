module Page
  class Base
    
    include Rails.application.routes.url_helpers
  
    def page_title
      find('h1').text
    end

    def window_title
      find('title').text
    end
    
    def alert
      find('#flash_alert').text
    end
    
    def notice
      find('#flash_notice').text
    end
    
    def has_message?(message)
      has_content?(message)
    end
    
    def errors
      all('.error_messages li').collect(&:text)
    end

    def method_missing(*args)
      if session.respond_to?(args.first)
        session.send(*args)
      end
    end
    
    private
    
    def session
      @session ||= Capybara.current_session
    end

  end
end

#World(PageModel)

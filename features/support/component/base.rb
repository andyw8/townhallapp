module Component
  class Base
    def initialize(selector)
      if Capybara.current_session.has_css?(selector)
        @root = Capybara.current_session.find(selector)
      end
    end

    def present?
      !@root.nil?
    end

    private

    def root
      @root
    end
  end
end

module Component
  class Base
    def initialize(root)
      @root = root
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

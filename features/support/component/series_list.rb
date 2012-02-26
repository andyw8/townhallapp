module Component
  class SeriesList < Component::Base
    def contents
      result = {}
      @root.all('li').each do |element|
        series_name = element.find('a').text
        result[series_name] = {
          :users => element.find('.users .value').text.to_i,
          :votes => element.find('.votes .value').text.to_i,
          :submissions => element.find('.submissions .value').text.to_i
        }
      end
      result
    end
  end
end

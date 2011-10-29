ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#require 'nulldb_rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true

  # this let us switch nulldb on or off per example group
  config.before(:each) do |example_group|
    unless example_group.example.metadata[:use_real_database]
      #include NullDB::RSpec::NullifiedDatabase
    end
  end

end

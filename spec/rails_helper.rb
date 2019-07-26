require 'spec_helper'

SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# require 'vcr'
# require 'webmock/rspec'
#
# VCR.configure do |config|
#   config.ignore_localhost = true
#   config.cassette_library_dir = 'spec/cassettes'
#   config.hook_into :webmock
#   config.configure_rspec_metadata!
#   config.filter_sensitive_data('<GITHUB_TOKEN>') { ENV['GITHUB_TOKEN'] }
# end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.after(:each) { FactoryBot.reload }

  config.after(:each) { Faker::UniqueGenerator.clear }

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'factory_girl.rb'
require 'support/user.rb'

# Set which broswer selenium uses.
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :safari)
# end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.include Capybara::DSL
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  config.after(:each, js: true) do
    DatabaseCleaner.clean
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
  # Disables the rspec-rails standard behaviour of wrapping each of your test examples within a transaction  
  # your DatabaseCleaner configuration will not work if this has not been updated
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.profile_examples = 10
  config.order = :random
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  Kernel.srand config.seed  
end

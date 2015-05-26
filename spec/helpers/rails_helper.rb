ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'billy/rspec'
require 'capybara/poltergeist'
require 'wait_for_ajax'
require 'stripe_helper'

ActiveRecord::Migration.maintain_test_schema!
Capybara.default_wait_time = 5
Capybara.javascript_driver = :poltergeist_billy

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

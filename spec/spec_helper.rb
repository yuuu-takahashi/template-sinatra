# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require_relative '../config/environment'
require 'factory_bot'
require 'rack/test'

require_with_alias('@/index')
require_with_alias('@/app/models/user')
require_with_alias('@/lib/database_client')

Rake.application.init
Rake.application.load_rakefile

Dir[File.join(__dir__, 'support', '**', '*.rb')].sort.each { |file| require file }

FactoryBot.definition_file_paths = %w[./spec/factories]
FactoryBot.find_definitions

RSpec.configure do |config|
  config.before(:suite) do
    Rake::Task['db:setup'].invoke
  end

  config.after(:suite) do
    Rake::Task['db:drop'].invoke
  end

  config.include FactoryBot::Syntax::Methods
  config.include Rack::Test::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  def app
    Sinatra::Application
  end
end

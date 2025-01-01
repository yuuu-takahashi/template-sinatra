require 'factory_bot'
require 'rack/test'
require 'faker'

ENV['RACK_ENV'] = 'test'

require_relative '../index'

Rake.application.init
Rake.application.load_rakefile

FactoryBot.definition_file_paths = %w[./spec/factories]
FactoryBot.find_definitions
FactoryBot.define do
  to_create do |instance|
    client = DatabaseClient.connect
    query = "INSERT INTO users (name, email) VALUES ('#{instance.name}', '#{instance.email}')"
    client.run(query)

    instance.id = client[:users].select(Sequel.function(:LAST_INSERT_ID).as(:id)).first[:id]
    client.disconnect
  end
end

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

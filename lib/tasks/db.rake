# frozen_string_literal: true

require 'rake'

require_relative '../../config/setup'
require_with_alias('@/config/initializers/database_client')
require_with_alias('@/db/setup')

namespace :db do
  desc 'Create the database'
  task :create do
    client = DatabaseClient.connect_without_database
    env = ENV['APP_ENV'] || 'development'
    database_name = DatabaseClient.database_name(env)
    create_database(client, database_name)
    client.close
    puts "Database '#{database_name}' created successfully!"
  end

  desc 'Drop the database'
  task :drop do
    client = DatabaseClient.connect
    env = ENV['APP_ENV'] || 'development'
    database_name = DatabaseClient.database_name(env)
    drop_database(client, database_name)
    client.close
    puts "Database '#{database_name}' dropped successfully!"
  end

  desc 'Setup the database'
  task setup: %i[create] do
    puts 'Database setup completed!'
  end

  desc 'Reset the database'
  task reset: %i[drop setup]
end

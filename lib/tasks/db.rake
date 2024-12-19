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

  desc 'Create the users table'
  task :create_table do
    client = DatabaseClient.connect
    create_users_table(client)
    client.close
    puts 'Users table created successfully!'
  end

  desc 'Seed the users data'
  task :seed_data do
    client = DatabaseClient.connect
    create_users_seed_data(client)
    client.close
    puts 'User seed data created successfully!'
  end

  desc 'Setup the database'
  task setup: %i[create create_table seed_data] do
    puts 'Database setup completed!'
  end

  desc 'Reset the database'
  task reset: %i[drop setup]
end

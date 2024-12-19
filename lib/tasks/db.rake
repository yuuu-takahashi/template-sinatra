# frozen_string_literal: true

require 'rake'

require_relative '../../config/setup'
require_with_alias('@/config/initializers/database_client')
require_with_alias('@/db/setup')

namespace :db do
  desc 'Create the database'
  task :create do
    client = DatabaseClient.connect_without_database
    create_database(client)
    client.close
  end

  desc 'Drop the database'
  task :drop do
    client = DatabaseClient.connect
    drop_database(client)
    client.close
  end

  desc 'Create the users table'
  task :migrate do
    client = DatabaseClient.connect
    create_table(client)
    create_schema_migrations_table(client)
    generate_schema(client)
    client.close
  end

  desc 'Seed the users data'
  task :seed do
    client = DatabaseClient.connect
    create_users_seed_data(client)
    client.close
  end

  desc 'Setup the database'
  task setup: %i[create migrate] do
    puts 'Database setup completed!'
  end

  desc 'Reset the database'
  task reset: %i[drop setup] do
    puts 'Database reset completed!'
  end
end

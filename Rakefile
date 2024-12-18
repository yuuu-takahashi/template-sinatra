# frozen_string_literal: true

require 'rake'

require_relative 'config/setup'
require_with_alias('@/config/initializers/database_client')
require_with_alias('@/db/setup')

namespace :db do
  task :create do
    client = DatabaseClient.connect_without_database
    env = ENV['APP_ENV'] || 'development'
    database_name = DatabaseClient.database_name(env)
    create_database(client, database_name)
    client.close
  end

  task :create_users_table do
    client = DatabaseClient.connect
    create_users_table(client)
    client.close
  end

  task :create_users_seed_data do
    client = DatabaseClient.connect
    create_users_seed_data(client)
    client.close
  end

  task setup: %i[create create_users_table] do
    puts 'Database setup completed!'
  end

  task :drop do
    client = DatabaseClient.connect
    env = ENV['APP_ENV'] || 'development'
    database_name = DatabaseClient.database_name(env)
    drop_database(client, database_name)
    client.close
  end

  task reset: %i[drop setup]
end

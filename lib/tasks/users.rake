# frozen_string_literal: true

require 'rake'

require_relative '../../config/setup'
require_with_alias('@/config/initializers/database_client')
require_with_alias('@/db/setup')

namespace :users do
  desc 'Create the users table'
  task :create_table do
    client = DatabaseClient.connect
    create_users_table(client)
    client.close
    puts 'Users table created successfully!'
  end

  desc 'Seed user data'
  task :seed_data do
    client = DatabaseClient.connect
    create_users_seed_data(client)
    client.close
    puts 'User seed data created successfully!'
  end
end

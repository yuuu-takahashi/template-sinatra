# frozen_string_literal: true

require 'rake'

require_relative 'config/environment'
require_with_alias('@/lib/database_client')
require_with_alias('@/db/setup')

namespace :db do
  task :create do
    client = DatabaseClient.connect_without_database
    create_database(client)
    client.disconnect
  end

  task :drop do
    client = DatabaseClient.connect
    drop_database(client)
    client.disconnect
  end

  task :migrate do
    client = DatabaseClient.connect
    create_table(client)
    generate_schema(client)
    client.disconnect
  end

  task :seed do
    client = DatabaseClient.connect
    create_users_seed_data(client)
    client.disconnect
  end

  task setup: %i[create migrate] do
    puts 'Database setup completed!'
  end

  task :generate_migrate, [:name] do |_t, args|
    migration_name = args[:name]
    puts "Generating migration for: #{migration_name}"
    generate_migrate_file(migration_name)
  end
end

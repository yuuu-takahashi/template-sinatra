# frozen_string_literal: true

require 'mysql2'
require 'yaml'
require_relative 'config/setup'
require_with_alias('@/config/initializers/database_client')
require_with_alias('@/db/setup')

begin
  client = DatabaseClient.connect
  create_schema_migrations_table(client)
  generate_schema(client)
rescue Mysql2::Error => e
  puts "Database error: #{e.message}"
rescue StandardError => e
  puts "An error occurred: #{e.message}"
ensure
  client&.close
end

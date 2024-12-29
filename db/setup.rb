# frozen_string_literal: true

require 'yaml'
require_with_alias('@/lib/database_client')
require_with_alias('@/db/utilities')

module DBSetup
  def self.create_database
    client = DatabaseClient.connect_without_database
    database_name = ENV['DATABASE_NAME']
    databases = client.fetch("SHOW DATABASES LIKE '#{database_name}'").all
    if databases.any?
      puts "Database '#{database_name}' already exists."
    else
      client.run("CREATE DATABASE `#{database_name}`")
      puts "Database '#{database_name}' created successfully!"
    end
  end

  def self.client
    @client ||= DatabaseClient.connect
  end

  def self.drop_database
    database_name = ENV['DATABASE_NAME']
    databases = client.fetch("SHOW DATABASES LIKE '#{database_name}'").all
    if databases.any?
      client.run("DROP DATABASE `#{database_name}`")
      puts "Database '#{database_name}' dropped successfully!"
    else
      puts "Database '#{database_name}' does not exist."
    end
  end

  def self.create_table
    if client.table_exists?(:users)
      puts "Table 'users' already exists."
    else
      Sequel.extension :migration
      Sequel::Migrator.run(client, 'db/migrate')
      puts "Table 'users' created successfully!"
    end
  end

  def self.create_users_seed_data
    user_count = client[:users].count

    if user_count.zero?
      users = YAML.load_file(File.join(File.dirname(__FILE__), 'seeds/users.yml'))
      users.each do |user|
        client[:users].insert(name: user['name'], email: user['email'])
      end
      puts 'users data inserted successfully!'
    else
      puts 'users data already exists. No data inserted.'
    end
  end

  def self.generate_schema
    File.open('db/schema.rb', 'w') do |file|
      write_schema_header(file)
      write_tables_schema(client, file)
      file.puts 'end'
    end
  end
end

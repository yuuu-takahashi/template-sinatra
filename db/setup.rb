# frozen_string_literal: true

require 'yaml'
require 'sequel'

def create_database(client)
  database_name = ENV['DATABASE_NAME']
  databases = client.fetch("SHOW DATABASES LIKE '#{database_name}'").all
  if databases.any?
    puts "Database '#{database_name}' already exists."
  else
    client.run("CREATE DATABASE `#{database_name}`")
    puts "Database '#{database_name}' created successfully!"
  end
end

def create_table(client)
  if client.table_exists?(:users)
    puts "Table 'users' already exists."
  else
    create_users_table_sql(client)
    puts "Table 'users' created successfully!"
  end
end

def create_users_table_sql(client)
  client.create_table?(:users) do
    primary_key :id
    String :name, null: false
    String :email, null: false, unique: true
    DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
    DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
  end
end

def create_users_seed_data(client)
  user_count = client[:users].count

  if user_count.zero?
    users = YAML.load_file(File.join(File.dirname(__FILE__), 'seeds/users.yml'))
    insert_users(client, users)
    puts 'users data inserted successfully!'
  else
    puts 'users data already exists. No data inserted.'
  end
end

def insert_users(client, users)
  users.each do |user|
    puts "Inserting user: #{user.inspect}"
    client[:users].insert(name: user['name'], email: user['email'])
  end
end

def drop_database(client)
  database_name = ENV['DATABASE_NAME']
  databases = client.fetch("SHOW DATABASES LIKE '#{database_name}'").all
  if databases.any?
    client.run("DROP DATABASE `#{database_name}`")
    puts "Database '#{database_name}' dropped successfully!"
  else
    puts "Database '#{database_name}' does not exist."
  end
end

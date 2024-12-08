# frozen_string_literal: true

def setup_database(client)
  database_name = 'template-sinatra_development'
  create_database(client, database_name)
  use_database(client, database_name)
  create_users_table(client)
end

def create_database(client, database_name)
  result = client.query("SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '#{database_name}'")
  if result.count.zero?
    client.query("CREATE DATABASE `#{database_name}`")
    puts "Database '#{database_name}' created successfully!"
  else
    puts "Database '#{database_name}' already exists."
  end
end

def use_database(client, database_name)
  client.query("USE `#{database_name}`")
end

def create_users_table(client)
  client.query(<<-SQL)
    CREATE TABLE IF NOT EXISTS users (
      id INT AUTO_INCREMENT PRIMARY KEY,
      username VARCHAR(255) NOT NULL,
      email VARCHAR(255) NOT NULL UNIQUE,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    )
  SQL
  puts "Table 'users' created successfully!"
end

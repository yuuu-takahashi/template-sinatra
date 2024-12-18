# frozen_string_literal: true

require 'yaml'

def create_database(client, database_name)
  result = client.query("SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '#{database_name}'")
  if result.count.zero?
    client.query("CREATE DATABASE `#{database_name}`")
    puts "Database '#{database_name}' created successfully!"
  else
    puts "Database '#{database_name}' already exists."
  end
end

def create_users_table(client)
  result = client.query("SHOW TABLES LIKE 'users'")
  if result.count.zero?
    client.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      )
    SQL
    puts "Table 'users' created successfully!"
  else
    puts "Table 'users' already exists."
  end
end

def create_users_seed_data(client)
  result = client.query('SELECT COUNT(*) AS count FROM users')
  user_count = result.first['count']

  if user_count.zero?
    users = YAML.load_file('users.yml')

    users.each do |user|
      client.query("INSERT INTO users (name, email) VALUES ('#{user['name']}', '#{user['email']}')")
    end
    insert_users_data(client)
    puts 'users data inserted successfully!'
  else
    puts 'users data already exists. No data inserted.'
  end
end

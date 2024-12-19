# frozen_string_literal: true

require 'yaml'

def create_database(client)
  database_name = ENV['DATABASE_NAME']
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
    create_users_table_sql(client)
    puts "Table 'users' created successfully!"
  else
    puts "Table 'users' already exists."
  end
end

def create_users_table_sql(client)
  client.query(<<-SQL)
    CREATE TABLE IF NOT EXISTS users (
      id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(255) NOT NULL,
      email VARCHAR(255) NOT NULL UNIQUE,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    )
  SQL
end

def create_users_seed_data(client)
  result = client.query('SELECT COUNT(*) AS count FROM users')
  user_count = result.first['count']

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
    puts "Inserting user: #{user.inspect}" #
    client.query("INSERT INTO users (name, email) VALUES ('#{user['name']}', '#{user['email']}')")
  end
end

def drop_database(client)
  database_name = ENV['DATABASE_NAME']
  result = client.query("SHOW DATABASES LIKE '#{database_name}'")
  if result.count.positive?
    client.query("DROP DATABASE `#{database_name}`")
    puts "Database '#{database_name}' dropped successfully!"
  else
    puts "Database '#{database_name}' does not exist."
  end
end

def create_schema_migrations_table(client)
  client.query(<<-SQL)
    CREATE TABLE IF NOT EXISTS schema_migrations (
      version VARCHAR(255) PRIMARY KEY
    );
  SQL

  puts 'Schema migrations table created successfully!'
end

def generate_schema(client)
  schema_file = 'db/schema.sql'
  tables = fetch_tables(client)

  File.open(schema_file, 'w') do |file|
    write_schema_header(file)
    write_tables_schema(file, client, tables)
  end

  puts "Schema file updated: #{schema_file}"
end

def fetch_tables(client)
  client.query('SHOW TABLES').map { |row| row.values.first }
end

def write_schema_header(file)
  file.puts '# This file is auto-generated. Do not edit manually.'
  file.puts "# Schema generated at: #{Time.now}\n\n"
end

def write_tables_schema(file, client, tables)
  tables.each do |table|
    result = client.query("SHOW CREATE TABLE #{table}").first
    create_table_sql = result['Create Table']

    file.puts "### Table: #{table}"
    file.puts "#{create_table_sql};\n\n"
  end
end

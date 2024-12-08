# frozen_string_literal: true

require 'sinatra'
require 'mysql2'

client = Mysql2::Client.new(
  host: ENV.fetch('DATABASE_HOST', nil),
  username: ENV.fetch('DATABASE_USER', nil),
  password: ENV.fetch('DATABASE_PASSWORD', nil)
)

database_name = 'template-sinatra_development'

begin
  result = client.query("SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '#{database_name}'")

  if result.count.zero?
    client.query("CREATE DATABASE `#{database_name}`")
    puts "Database '#{database_name}' created successfully!"
  else
    puts "Database '#{database_name}' already exists."
  end
rescue Mysql2::Error => e
  puts "An error occurred: #{e.message}"
end

begin
  client.query("USE `#{database_name}`")
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
rescue Mysql2::Error => e
  puts "An error occurred: #{e.message}"
end

begin
  result = client.query('SELECT COUNT(*) AS count FROM users')
  user_count = result.first['count']

  if user_count == 0
    client.query <<-SQL
      INSERT INTO users (username, email)
      VALUES
        ('JohnDoe', 'johndoe@example.com'),
        ('JaneSmith', 'janesmith@example.com'),
        ('TestUser', 'testuser@example.com');
    SQL
    puts 'Sample data inserted successfully!'
  else
    puts 'Sample data already exists. No data inserted.'
  end
rescue Mysql2::Error => e
  puts "An error occurred while inserting data: #{e.message}"
end

get '/' do
  result = client.query('SELECT * FROM users')
  users = result.map(&:to_h)
  content_type :json
  users.to_json
rescue Mysql2::Error => e
  status 500
  { error: e.message }.to_json
end

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
ensure
  client.close
end

get '/' do
  'Hello world!'
end

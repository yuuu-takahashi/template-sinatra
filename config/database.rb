# frozen_string_literal: true

require 'mysql2'

def database_client
  Mysql2::Client.new(
    host: ENV.fetch('DATABASE_HOST', 'localhost'),
    username: ENV.fetch('DATABASE_USER', 'root'),
    password: ENV.fetch('DATABASE_PASSWORD', ''),
    database: ENV.fetch('DATABASE_NAME', nil)
  )
end

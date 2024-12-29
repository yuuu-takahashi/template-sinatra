# frozen_string_literal: true

# frozen_string_literal: true

require 'rake'

require_relative './config/setup'
require_with_alias('@/config/initializers/database_client')
require_with_alias('@/db/setup')

namespace :db do
  desc 'データベースを作成します'
  task :create do
    client = Mysql2::Client.new(
      host: ENV['DATABASE_HOST'],
      username: ENV['DATABASE_USER'],
      password: ENV['DATABASE_PASSWORD']
    )

    db_name = ENV['DATABASE_NAME']
    client.query("CREATE DATABASE IF NOT EXISTS #{db_name}")
    puts "データベースを作成しました: #{db_name}"
  rescue Mysql2::Error => e
    puts "エラーが発生しました: #{e.message}"
  ensure
    client&.close
  end

  desc 'データを追加します'
  task :seed do
    client = Mysql2::Client.new(
      host: ENV['DATABASE_HOST'],
      username: ENV['DATABASE_USER'],
      password: ENV['DATABASE_PASSWORD'],
      database: ENV['DATABASE_NAME']
    )

    client.query(<<~SQL)
      CREATE TABLE IF NOT EXISTS users (
       id INT AUTO_INCREMENT PRIMARY KEY,
       name VARCHAR(255),
       email VARCHAR(255)
      );
    SQL

    client.query("INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com')")
    client.query("INSERT INTO users (name, email) VALUES ('Bob', 'bob@example.com')")
    puts 'サンプルデータを追加しました'
  rescue Mysql2::Error => e
    puts "エラーが発生しました: #{e.message}"
  ensure
    client&.close
  end
end

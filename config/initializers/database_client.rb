# frozen_string_literal: true

require 'erb'
require 'sequel'
require 'yaml'

module DatabaseClient
  def self.connect_without_database
    Sequel.connect(
      adapter: 'mysql2',
      host: ENV.fetch('DATABASE_HOST'),
      user: ENV.fetch('DATABASE_USER'),
      password: ENV.fetch('DATABASE_PASSWORD')
    )
  end

  def self.connect
    Sequel.connect(
      adapter: 'mysql2',
      host: ENV.fetch('DATABASE_HOST'),
      user: ENV.fetch('DATABASE_USER'),
      password: ENV.fetch('DATABASE_PASSWORD'),
      database: ENV.fetch('DATABASE_NAME')
    )
  end
end

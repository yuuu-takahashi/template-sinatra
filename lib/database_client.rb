# frozen_string_literal: true

require 'erb'
require 'sequel'
require 'yaml'

module DatabaseClient
  def self.connect_without_database
    Sequel.connect(
      adapter: 'mysql2',
      host: ENV['DATABASE_HOST'],
      user: ENV['DATABASE_USER'],
      password: ENV['DATABASE_PASSWORD']
    )
  end

  def self.connect
    Sequel.connect(
      adapter: 'mysql2',
      host: ENV['DATABASE_HOST'],
      user: ENV['DATABASE_USER'],
      password: ENV['DATABASE_PASSWORD'],
      database: ENV['DATABASE_NAME']
    )
  end
end

# frozen_string_literal: true

require 'erb'
require 'mysql2'
require 'yaml'

module DatabaseClient
  def self.connect_without_database
    Mysql2::Client.new(
      host: config['host'],
      username: config['username'],
      password: config['password']
    )
  end

  def self.connect
    Mysql2::Client.new(
      host: config['host'],
      username: config['username'],
      password: config['password'],
      database: ENV['DATABASE_NAME']
    )
  end

  def self.config
    @config ||= begin
      env = ENV.fetch('APP_ENV', 'development')

      db_config_path = File.expand_path('../../config/database.yml', __dir__)
      erb = ERB.new(File.read(db_config_path))
      db_config = YAML.safe_load(erb.result, aliases: true)
      db_config[env]
    end
  end

  private_class_method :config
end

# frozen_string_literal: true

require 'mysql2'
require 'yaml'
require 'erb'

module DatabaseClient
  def self.connect_without_database
    Mysql2::Client.new(
      host: config['host'],
      username: config['username'],
      password: config['password']
    )
  end

  def self.connect(env = ENV.fetch('APP_ENV', 'development'))
    Mysql2::Client.new(
      host: config['host'],
      username: config['username'],
      password: config['password'],
      database: database_name(env)
    )
  end

  def self.database_name(env)
    case env
    when 'test'
      # TODO:
      'template-sinatra_test'
    when 'production'
      'template-sinatra_production'
    else
      'template-sinatra_development'
    end
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

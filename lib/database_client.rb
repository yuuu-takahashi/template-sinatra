module DatabaseClient
  def self.connect_without_database
    connect_to_database
  end

  def self.connect
    connect_to_database(database: ENV['DATABASE_NAME'])
  end

  def connect_to_database(database: nil)
    Sequel.connect(
      adapter: 'mysql2',
      host: ENV.fetch('DATABASE_HOST', 'db'),
      user: ENV['DATABASE_USER'],
      password: ENV['DATABASE_PASSWORD'],
      database: database
    )
  end

  module_function :connect_to_database
end

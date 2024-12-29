# frozen_string_literal: true

class User
  attr_accessor :id
  attr_reader :name, :email, :created_at, :updated_at

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
    @email = attributes['email']
    @created_at = attributes['created_at']
    @updated_at = attributes['updated_at']
  end

  def self.all
    with_database_client do |client|
      query = 'SELECT * FROM users'
      results = client.query(query, symbolize_keys: true)
      results.map { |row| new(row) }
    end
  end

  def self.find(id)
    with_database_client do |client|
      query = 'SELECT * FROM users WHERE id = ? LIMIT 1'
      statement = client.prepare(query)
      result = statement.execute(id).first
      result ? new(result) : nil
    end
  end

  def to_h
    {
      id: @id,
      name: @name,
      email: @email,
      created_at: @created_at,
      updated_at: @updated_at
    }
  end

  def self.with_database_client
    client = DatabaseClient.connect
    yield(client)
  ensure
    client&.close
  end
end

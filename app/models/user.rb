# frozen_string_literal: true

class User
  attr_reader :id, :username, :email, :created_at, :updated_at

  def initialize(attributes)
    @id = attributes['id']
    @username = attributes['username']
    @username = attributes['email']
    @created_at = attributes['created_at']
    @updated_at = attributes['updated_at']
  end

  def self.all(client)
    results = client.query('SELECT * FROM users')
    results.map { |row| new(row) }
  end
end

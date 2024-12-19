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

  def self.all(client)
    results = client.query('SELECT * FROM users')
    results.map { |row| new(row) }
  end

  def self.find(client, id)
    results = client.query("SELECT * FROM users WHERE id = #{id}")
    new(results.first)
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
end

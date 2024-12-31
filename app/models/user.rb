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
      client.fetch(query).all
    end
  end

  def self.find(id)
    with_database_client do |client|
      query = 'SELECT * FROM users WHERE id = ? LIMIT 1'
      user = client.fetch(query, id).first
      raise Sinatra::NotFound, 'User not found' unless user

      user
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
    client.disconnect
  end
end

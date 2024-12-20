# frozen_string_literal: true

require_relative '../../config/setup'
require_with_alias('@/app/models/user')
require_with_alias('@/config/initializers/database_client')

FactoryBot.define do
  to_create do |instance|
    client = DatabaseClient.connect
    query = "INSERT INTO users (name, email) VALUES ('#{instance.name}', '#{instance.email}')"
    client.query(query)

    result = client.query('SELECT LAST_INSERT_ID() AS id').first
    instance.id = result['id']
    client.disconnect
  end
end

# frozen_string_literal: true

FactoryBot.define do
  to_create do |instance|
    client = DatabaseClient.connect
    query = "INSERT INTO users (name, email) VALUES ('#{instance.name}', '#{instance.email}')"
    client.fetch(query)

    result = client.fetch('SELECT LAST_INSERT_ID() AS id').first
    instance.id = result['id']
    client.disconnect
  end
end

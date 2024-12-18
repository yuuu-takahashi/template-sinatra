# frozen_string_literal: true

require_relative '../../config/setup'
require_with_alias('@/app/models/user')
require_relative '../../config/initializers/database_client'

FactoryBot.define do
  to_create do |instance|
    client = DatabaseClient.connect
    query = "INSERT INTO users (name, email) VALUES ('#{instance.name}', '#{instance.email}')"
    client.query(query)
    client.close
  end
end

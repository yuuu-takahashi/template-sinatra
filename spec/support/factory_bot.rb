# frozen_string_literal: true

require_relative '../../config/setup'
require_with_alias('@/app/models/user')
require_with_alias('@/config/initializers/database_client')

FactoryBot.define do
  to_create do |instance|
    client = DatabaseClient.connect
    client[:users].insert(name: instance.name, email: instance.email)

    instance.id = client[:users].select(Sequel.function(:LAST_INSERT_ID).as(:id)).first[:id]
    client.disconnect
  end
end

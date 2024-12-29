# frozen_string_literal: true

FactoryBot.define do
  to_create do |instance|
    client = DatabaseClient.connect
    query = "INSERT INTO users (name, email) VALUES ('#{instance.name}', '#{instance.email}')"
    client.run(query)

    instance.id = client[:users].select(Sequel.function(:LAST_INSERT_ID).as(:id)).first[:id]
    client.disconnect
  end
end

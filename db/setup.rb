# frozen_string_literal: true

require_relative 'config/setup'
require_with_alias('@/app/services/database_client')
require_with_alias('@/db/schema')
require_with_alias('@/db/seeds')

client = DatabaseClient.connect

setup_database(client)
seed_data(client)
client.close

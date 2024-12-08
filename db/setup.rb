# frozen_string_literal: true

require_relative 'app/services/database_client'
require_relative '../db/schema'
require_relative '../db/seeds'

client = DatabaseClient.connect

setup_database(client)
seed_data(client)
client.close

# frozen_string_literal: true

require 'sinatra'
require_relative 'config/database'
require_relative 'db/schema'
require_relative 'db/seeds'
require_relative 'app/routes/users'

client = database_client

# データベースのセットアップ
setup_database(client)
seed_data(client)
client.close

# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'config/database'
require_relative 'db/schema'
require_relative 'db/seeds'

get '/' do
  'Hello, world!'
end

require_relative 'app/routes/users'

client = database_client

# データベースのセットアップ
setup_database(client)
seed_data(client)
client.close

# frozen_string_literal: true

require 'sinatra'
require_relative '../../config/database'
require_relative '../../app/models/user'

get '/users' do
  client = database_client
  users = User.all(client)
  content_type :json
  users.map(&:to_h).to_json
rescue Mysql2::Error => e
  status 500
  { error: e.message }.to_json
ensure
  client&.close
end

# frozen_string_literal: true

require 'sinatra/base'
require_relative '../../config/setup'
require_with_alias('@/app/models/user')
require_with_alias('@/app/services/database_client')

class UsersController < Sinatra::Base
  before do
    content_type :json
  end

  get '/users' do
    with_database_client do |client|
      users = User.all(client)
      users.map(&:to_h).to_json
    end
  end

  get '/users/:id' do
    with_database_client do |client|
      user = User.find(client, params[:id])
      user.to_h.to_json
    end
  end

  private

  def with_database_client
    client = DatabaseClient.connect
    yield(client)
  rescue Mysql2::Error => e
    status 500
    { error: e.message }.to_json
  ensure
    client&.close
  end
end

# frozen_string_literal: true

require 'sinatra/base'
require_relative '../../config/environment'
require_with_alias('@/app/models/user')
require_with_alias('@/lib/database_client')

class UsersController < Sinatra::Base
  before do
    content_type :json
  end

  def self.index
    users = User.all(client)
    users.map(&:to_h).to_json
  end

  def self.show(params)
    user = User.find(client, params[:id])
    user.to_h.to_json
  end
end

# frozen_string_literal: true

class UsersController < Sinatra::Base
  before do
    content_type :json
  end

  def self.index
    users = User.all
    users.map(&:to_h).to_json
  end

  def self.show(params)
    user = User.find(params[:id])
    user.to_h.to_json
  end
end

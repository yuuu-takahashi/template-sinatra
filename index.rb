# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'config/setup'
require_with_alias('@/app/controllers/users_controller')

set :bind, '0.0.0.0'
set :port, 4567

ROUTES = {
  get: {
    '/users' => [UsersController, :index],
    '/users/:id' => [UsersController, :show]
  }
}.freeze

ROUTES.each do |http_method, paths|
  paths.each do |path, (controller, action)|
    send(http_method, path) do
      if params.empty?
        controller.send(action)
      else
        controller.send(action, params)
      end
    end
  end
end

get '/' do
  "Hello World #{params[:name]}".strip
end

# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'db/setup' if ENV['RUN_SETUP'] == 'true'
require_relative 'app/controllers/users_controller'

set :bind, '0.0.0.0'
set :port, 4567

use UsersController

get '/' do
  'Hello, world!'
end

# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'config/environment'
require_with_alias('@/lib/database_client')
require_with_alias('@/app/models/user')
require_with_alias('@/app/controllers/top_controller')
require_with_alias('@/app/controllers/users_controller')
require_with_alias('@/config/routes')

set :bind, '0.0.0.0'
set :port, 4567

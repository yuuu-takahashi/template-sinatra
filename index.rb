# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'config/environment'
require_with_alias('@/config/routes')
require_with_alias('@/app/models/user')
require_with_alias('@/lib/database_client')

set :bind, '0.0.0.0'
set :port, 4567

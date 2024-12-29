# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'config/setup'
require_with_alias('@/config/environment')
require_with_alias('@/config/routes')


set :bind, '0.0.0.0'
set :port, 4567

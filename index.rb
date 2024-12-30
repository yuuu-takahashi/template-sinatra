require 'sinatra'
require 'sinatra/reloader' if development?
require 'sequel'
require 'sinatra/base'
require 'sequel/extensions/migration'
require 'yaml'

require_relative 'config/environment'

Dir[File.join(__dir__, '{app,config,db,lib}/**/*.rb')].each do |file|
  relative_path = file.sub("#{__dir__}/", '').sub(/\.rb$/, '')
  require_relative relative_path
  also_reload relative_path if development?
end

set :bind, '0.0.0.0'
set :port, 4567

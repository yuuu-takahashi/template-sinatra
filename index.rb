require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'config/environment'

Dir[File.join(__dir__, '{app,config,db,lib}/**/*.rb')].each do |file|
  require_relative file
  also_reload file if development?
end

set :bind, '0.0.0.0'
set :port, 4567

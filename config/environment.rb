# frozen_string_literal: true

require 'dotenv'

APP_ROOT = File.expand_path('..', __dir__)

env_file = case ENV['APP_ENV']
           when 'production'
             File.join(APP_ROOT, '.env.production')
           when 'test'
             File.join(APP_ROOT, '.env.test')
           else
             File.join(APP_ROOT, '.env')
           end

if File.exist?(env_file)
  puts 'Env file found'
else
  raise "Error: Env file not found at #{env_file}"
end

Dotenv.overload(env_file)

def require_with_alias(path)
  require path.sub('@/', "#{APP_ROOT}/")
end

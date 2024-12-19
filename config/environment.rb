# frozen_string_literal: true

require 'dotenv'

env_file = case ENV['APP_ENV']
           when 'production'
             File.expand_path('../.env.production', __dir__)
           when 'test'
             File.expand_path('../.env.test', __dir__)
           else
             File.expand_path('../.env', __dir__)
           end

puts "Using env file: #{env_file}"

if File.exist?(env_file)
  puts 'Env file found'
else
  puts 'Env file not found!'
end

loaded_vars = Dotenv.overload(env_file)
puts "Loaded variables: #{loaded_vars.inspect}"

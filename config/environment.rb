# frozen_string_literal: true

require 'dotenv'

env_file = case ENV['APP_ENV']
           when 'production'
             '.env.production'
           when 'test'
             '.env.test'
           else
             '.env'
           end

Dotenv.load(env_file)

puts "Loaded environment: #{ENV['APP_ENV']}"

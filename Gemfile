# frozen_string_literal: true

source 'https://rubygems.org'

gem 'dotenv'
gem 'mysql2', '~> 0.5.6'
gem 'puma', '~> 6.5'
gem 'rackup', require: false
gem 'rake', '~> 13.0'
gem 'sequel', '~> 5.47', require: false
gem 'sinatra', '~> 4.1'

group :development, :test do
  gem 'factory_bot', '~> 6.2', require: false
  gem 'rack-test', require: false
  gem 'rspec', '~> 3.12', require: false
  gem 'rubocop', require: false
end

group :test do
  gem 'faker', require: false
end

group :development do
  gem 'ruby-lsp', require: false
  gem 'sinatra-contrib', require: false
end

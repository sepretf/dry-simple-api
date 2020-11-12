# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

# Use Puma as the app server
gem 'puma', '~> 4.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'pg', '~> 0.18.4'

# Emails
gem 'sendgrid', '1.2.4'
gem 'sendgrid_webapi', git: 'https://github.com/nicovak/sendgrid_webapi'


# Workers
gem 'connection_pool', '2.2.3'
gem 'sidekiq', '5.2.9'
gem 'sidekiq-failures', '1.0.0'
gem 'influxdb'
gem 'sidekiq-influxdb', '~> 1.3.0'
gem 'sidekiq-logging-json', '0.0.19'
gem 'sidekiq-unique-jobs', '6.0.24'
gem 'whenever', '1.0.0', require: false

# Dry-rb
gem 'dry-auto_inject', '~> 0.4.6'
gem 'dry-initializer', '3.0.4'
gem 'dry-matcher', '0.8.3'
gem 'dry-monads', '1.3.0'
gem 'dry-struct', '1.0.0'
gem 'dry-schema', '1.3.3'
gem 'dry-types', '1.1.1'
gem 'dry-validation', '1.3.1'


# Formatter
gem 'json', '>= 2.0.0'
gem 'awesome_print', '1.8.0'
gem 'jsonapi-serializer', '2.1.0'
gem 'html_to_plain_text', '1.0.5'
gem 'strip_attributes', '~> 1.11'

# Auth
gem 'jwt', '2.2.2'


# MISC
gem 'bcrypt', '3.1.16'
gem 'bcrypt_pbkdf', '1.0.1'
gem 'ed25519', '1.2.4'
gem 'uglifier', '4.2.0'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'pry-nav', '~> 0.3.0'
  gem 'pry-rails', '~> 0.3.9'
  gem 'pry-remote', '~> 0.1.8'
  gem 'pry-stack_explorer', '~> 0.4.9.3'

  gem 'rubocop', '~> 0.93.1', require: false
  gem 'rubocop-performance', '~> 1.8.1', require: false
  gem 'rubocop-rails', '~> 2.8.1', require: false
  gem 'rubocop-rspec', '~> 1.44.1', require: false

  gem 'factory_bot', '~> 5.0.2'
  gem 'factory_bot_rails', '~> 5.0.1'
  gem 'mock_redis', '~> 0.18.0', require: false
  gem 'rspec-rails', '~> 4.0.1'
  gem 'simplecov', require: false
end

group :test do
  gem 'rspec-sidekiq', '~> 3.1.0'
  gem 'webmock', '~> 3.9.3'
  gem 'database_cleaner-active_record'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

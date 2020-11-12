# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  config.log_level = :debug

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
        'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  # config.consider_all_requests_local       = true
  config.action_mailer.default_url_options = { host: '0.0.0.0:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address: 'localhost',
      port:    1025,
      domain:  'localhost'
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
# frozen_string_literal: true

class ApplicationValidator < Dry::Validation::Contract
  config.messages.top_namespace = 'plezi'
  config.messages.load_paths << 'config/locales/errors.yml'
end

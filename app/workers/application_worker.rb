# frozen_string_literal: true

require 'dry/monads/result'
require 'dry/matcher/result_matcher'

class ApplicationWorker
  include Sidekiq::Worker
  include Dry::Monads[:result]

  def self.layer(&block)
    define_method(:layer, &block)
  end

  def perform(input = {})
    monad = input.present? ? layer.call(params(input)) : layer.call

    Dry::Matcher::ResultMatcher.call(monad) do |matcher|
      matcher.success { |value| on_success(input, value) }
      matcher.failure { |error| on_failure(input, error) }
    end
  end

  private def params(input)
    input.symbolize_keys
  end

  private def on_success(_input, _value); end

  private def on_failure(_input, _error); end
end

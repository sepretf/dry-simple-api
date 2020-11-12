# frozen_string_literal: true

class ApplicationForm
  include Dry::Monads[:try, :do, :result, :maybe]
  extend Dry::Initializer

  NONE_VALIDATOR = ->(args) { Dry::Monads::Success.new(args) }

  def self.validator(&block)
    define_method(:default_validator, &block)
    define_method(:default_validator?) { true }
  end

  option :dynamic_fields, default: -> { false }
  option :validator,      default: -> { nil }

  def call(params)
    validator.call(params)
        .to_monad
        .or {   |result| params_invalid(result.errors) }
        .bind { |result| params_valid(result.to_h) }
  end

  private

  def validator
    @validator || NONE_VALIDATOR
  end

  # Default implementation
  def params_invalid(errors)
    Failure.new(errors.to_h)
  end

  # Default implementation
  def default_validator(_result); end

  def default_validator?
    false
  end
end


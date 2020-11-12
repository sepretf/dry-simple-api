# frozen_string_literal: true

class ApplicationService
  include Dry::Monads[:try, :do, :result, :maybe]
  extend Dry::Initializer
end

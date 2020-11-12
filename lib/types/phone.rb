# frozen_string_literal: true

module Types
  Phone = Types::String.constrained(
    format: /\d{10}(\d)*/
  )
end

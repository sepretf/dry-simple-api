# frozen_string_literal: true

module Types
  Password = Types::String.constrained(
    format: PASSWORD_FORMAT
  )
end

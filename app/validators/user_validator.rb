# frozen_string_literal: true

class UserValidator < ApplicationValidator
  option :query

  params do
    required(:email).filled(Types::Email)
    required(:first_name).filled(:string)
    required(:last_name).filled(:string)
    required(:password).filled(Types::Password)
  end

  rule(:email) do
    selector = { email: values[:email] }

    key.failure('must be uniq') if query.call(selector: selector).exists?
  end
end

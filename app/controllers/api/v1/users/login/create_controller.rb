# frozen_string_literal: true

module API
  module V1
    module Users
      module Login
        class CreateController < ApplicationController
          option :query, default: -> { Query.new(User) }

          def call
            if user.present? && user.authenticate(password)
              on_success(body: user)
            else
              on_failure(error: 'Invalid email or password')
            end
          end

          private

          def authorized
            true
          end

          def email
            params.require(:email)
          end

          def password
            params.require(:password)
          end

          def user
            @user ||= @query.call(selector: { email: email }).first
          end

          def serialized_output(data)
            token = encode_token({user_id: data.id})

            UserSerializer.new(data, params: { token: token }).serialized_json
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module API
  module V1
    module Users
      class CreateController < ApplicationController
        ALLOWED_PARAMS = [
            :email,
            :first_name,
            :last_name,
            :password
        ].freeze

        option :form, default: -> { ::Users::CreateForm.new }

        def call
          Dry::Matcher::ResultMatcher.call(persist) do |matcher|
            matcher.success { |user| on_success(status: 201, body: user) }
            matcher.failure { |error| on_failure(category: :users, error: error) }
          end
        end

        private

        def authorized
          true
        end

        def persist
          form.call(params: allowed_params)
        end

        def allowed_params
          params.permit(*ALLOWED_PARAMS).to_h
        end

        def serialized_output(data)
          token = encode_token({ user_id: data.id })

          UserSerializer.new(data, params: { token: token }).serialized_json
        end
      end
    end
  end
end

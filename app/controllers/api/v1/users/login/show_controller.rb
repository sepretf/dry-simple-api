# frozen_string_literal: true

module API
  module V1
    module Users
      module Login
        class ShowController < ApplicationController
          def call
            on_success(body: @user)
          end

          private

          def serialized_output(data)
            token = encode_token({user_id: data.id})

            UserSerializer.new(data, params: { token: token }).serialized_json
          end
        end
      end
    end
  end
end

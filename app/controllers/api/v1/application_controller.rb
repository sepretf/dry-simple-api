# frozen_string_literal: true

require 'dry/matcher/result_matcher'
require 'dry/monads'

module API
  module V1
    class RenderReturnException < StandardError; end

    class ApplicationController < ActionController::API
      include ActionController::Cookies
      include Concerns::Resultable
      include Dry::Monads[:try, :result, :maybe]
      extend Dry::Initializer

      before_action :authorized

      rescue_from RenderReturnException, with: :render_return
      rescue_from ActionController::ParameterMissing, with: :param_missing

      def render_return; end

      def param_missing(_)
        error = { request: ['invalid arguments'] }
        render json: { errors: translate_error(:main, error) }, status: :bad_request
      end

      def encode_token(payload)
        JWT.encode(payload, SECRET_TOKEN)
      end

      # header: { 'Authorization': 'Bearer <token>' }
      def auth_header
        request.headers['Authorization']
      end

      def decoded_token
        if auth_header
          token = auth_header.split(' ')[1]
          begin
            JWT.decode(token, SECRET_TOKEN, true, algorithm: 'HS256')
          rescue JWT::DecodeError
            nil
          end
        end
      end

      def logged_in_user
        if decoded_token
          user_id = decoded_token[0]['user_id']
          @user = User.find_by(id: user_id)
        end
      end

      def logged_in?
        !!logged_in_user
      end

      def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
      end
    end
  end
end

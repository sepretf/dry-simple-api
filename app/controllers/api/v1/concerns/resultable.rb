# frozen_string_literal: true

require 'string'

module API
  module V1
    module Concerns
      module Resultable
        def self.included(klass)
          klass.include(InstanceMethods)
        end

        module InstanceMethods
          private

          # stop and return
          def on_success(status: 200, body: {})
            halt status: status, body: serialized_output(body)
          end

          # stop and return
          def on_failure(error:, status: 400, category: :main)
            halt status: status, body: { errors: translate_error(category, error) }
          end

          # stop and return
          def halt(status: 400, body: {})
            render status: status, json: body

            raise RenderReturnException
          end

          def translate_error(category, error)
            return error if error.instance_of?(String)

            error.map do |field_name, (message, _)|
              i18n_key = "plezi.errors.#{category}.#{field_name}_#{message.to_s.slugify}"
              {
                code:       I18n.t("#{i18n_key}.code", default: 'N/A'),
                message:    I18n.t("#{i18n_key}.message", default: "#{field_name.to_s.humanize} #{message}"),
                field_name: field_name.to_s
              }
            end
          end

          def serialized_output(data)
            data.to_json
          end
        end
      end
    end
  end
end

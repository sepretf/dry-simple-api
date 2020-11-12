# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Params
        extend self

        def presence(sort_name, default: nil)
          sort_name.presence || default
        end

        def positive(number, default: 0)
          number.to_i.positive? ? number.to_i : default
        end
      end
    end
  end
end

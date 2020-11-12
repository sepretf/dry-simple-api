# frozen_string_literal: true

module Pg
  class DeleteForm < ApplicationForm
    def initialize(element, **kwargs)
      @element = element

      super(**kwargs)
    end

    private

    def sanitize(params)
      params
    end

    def params_valid(_params)
      if @element.delete
        Success(@element)
      else
        Failure(@element.errors)
      end
    end
  end
end

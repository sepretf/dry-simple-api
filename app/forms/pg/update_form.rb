# frozen_string_literal: true

module Pg
  class UpdateForm < ApplicationForm
    def initialize(element, **kwargs)
      @element = element

      super(**kwargs)
    end

    private

    def class_name
      @element.class
    end

    def params_valid(params)
      if @element.update(params)
        Success(@element)
      else
        Failure(@element.errors)
      end
    end
  end
end

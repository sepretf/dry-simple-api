# frozen_string_literal: true

module Pg
  class SaveForm < ApplicationForm
    def initialize(klass, **kwargs)
      @klass = klass

      super(**kwargs)
    end

    private

    def class_name
      @klass
    end

    def params_valid(params)
      model = @klass.new(params)

      if model.save
        Success(model)
      else
        Failure(model.errors)
      end
    end
  end
end

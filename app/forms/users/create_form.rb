# frozen_string_literal: true

module Users
  class CreateForm < ApplicationForm
    option :form, default: -> { Pg::SaveForm.new(User, validator: UserValidator.new(query: Query.new(User))) }

    def call(params:)
      @form.call(params)
    end
  end
end

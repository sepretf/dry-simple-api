# frozen_string_literal: true

class Query
  def initialize(criteria)
    @criteria = criteria

    freeze
  end

  def call(selector:)
    @criteria.where(selector)
  end
end

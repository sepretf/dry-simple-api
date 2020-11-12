# frozen_string_literal: true

class InstantJob
  def initialize(klass)
    @klass = klass.new
  end

  def call(*params)
    @klass.perform(*params)
  end
end

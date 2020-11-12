# frozen_string_literal: true

class DelayedJob
  def initialize(klass)
    @klass = klass
  end

  def call(*params)
    @klass.perform_async(*params)
  end
end

# frozen_string_literal: true

class String
  def slugify(separator: '_')
    downcase.parameterize.gsub(/[^a-z]+/i, separator)
  end

  def trim
    self&.strip
  end
end

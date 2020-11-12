# frozen_string_literal: true

class BaseSerializer
  include JSONAPI::Serializer

  attributes :id

  attribute :id do |object|
    object.id.to_s
  end

  def serialized_json
    serializable_hash.to_json
  end
end

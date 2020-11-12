# frozen_string_literal: true

class UserSerializer < BaseSerializer
  attributes :email, :first_name, :last_name

  attribute :token do |_, params|
    params[:token].presence || 'N/A'
  end
end

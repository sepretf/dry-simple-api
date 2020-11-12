module AuthorizationHelper
  def encode_token(user)
    JWT.encode({ user_id: user.id }, SECRET_TOKEN)
  end
end
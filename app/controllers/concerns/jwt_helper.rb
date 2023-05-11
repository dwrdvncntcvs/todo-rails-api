module JsonWebToken
  SECRET_KEY = Rails.application.secret_key_base

  def jwt_encode(_payload, _exp = 7.day.from_now)
    _payload[:exp] = _exp.to_i
    JWT.encode(_payload, SECRET_KEY)
  end

  def jwt_decode(token)
    decoded_data = JWT.decode(token, SECRET_KEY)
    HashWithIndifferentAccess.new decoded_data
  end
end

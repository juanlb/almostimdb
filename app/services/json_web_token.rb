# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def self.encode(payload, _private_key = nil)
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token, _public_key = nil)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end

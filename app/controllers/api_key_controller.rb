# frozen_string_literal: true

class ApiKeyController < ApplicationController
  def index
    payload = {
      user_id: current_user.id
    }
    @jwt = JsonWebToken.encode(payload)
  end
end

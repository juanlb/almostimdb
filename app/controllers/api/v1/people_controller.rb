# frozen_string_literal: true

class Api::V1::PeopleController < ApiController
  def index
    render json: PersonSerializer.new(Person.all).serializable_hash
 end
end

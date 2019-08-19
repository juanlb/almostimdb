# frozen_string_literal: true

class Api::V1::PeopleController < ApiController
  def index
    options = {}
    options[:include] = [:movies_as_director, :movies_as_producer, :movies_as_member]

    render json: PersonSerializer.new(Person.all, options).serializable_hash
  end
end

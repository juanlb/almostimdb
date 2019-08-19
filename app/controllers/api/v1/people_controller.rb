# frozen_string_literal: true

class Api::V1::PeopleController < ApiController
  SERIALIZER_OPTIONS = {
    include: [:movies_as_director, :movies_as_producer, :movies_as_member]
  }.freeze

  before_action :set_person, only: [:show]

  def index
    options = {}
    options[:include] = [:movies_as_director, :movies_as_producer, :movies_as_member]

    render json: PersonSerializer.new(Person.all, SERIALIZER_OPTIONS).serializable_hash
  end

  def show
    render json: PersonSerializer.new(@person, SERIALIZER_OPTIONS).serializable_hash
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end
end

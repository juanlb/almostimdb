# frozen_string_literal: true

class Api::V1::PeopleController < ApiController
  SERIALIZER_OPTIONS = {
    include: [:movies_as_director, :movies_as_producer, :movies_as_member]
  }.freeze

  before_action :set_person, only: [:show, :update, :destroy]

  def index
    render json: PersonSerializer.new(Person.all, SERIALIZER_OPTIONS).serializable_hash
  end

  def show
    render json: PersonSerializer.new(@person, SERIALIZER_OPTIONS).serializable_hash
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      render json: PersonSerializer.new(@person, SERIALIZER_OPTIONS).serializable_hash
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def update
    if @person.update(person_params)
      render json: PersonSerializer.new(@person, SERIALIZER_OPTIONS).serializable_hash
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @person.destroy
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :aliases)
  end
end

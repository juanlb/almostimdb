# frozen_string_literal: true

class Api::V1::DirectorsController < ApiController
  SERIALIZER_OPTIONS = {
    include:  [:directors, :producers, :casting]
  }.freeze

  before_action :set_movie
  before_action :set_direction, only: [:destroy]

  def index
    render json: PersonResumedSerializer.new(@movie.directors).serializable_hash
  end

  def create
    direction = Direction.new(direction_params)
    direction.movie = @movie
    if direction.save
      render json: MovieSerializer.new(@movie, SERIALIZER_OPTIONS).serializable_hash
    else
      render json: direction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @direction.destroy
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_direction
    @direction = @movie.directions.find_by!(person_id: params[:id])
  end

  def direction_params
    params.require(:director).permit(:person_id)
  end
end

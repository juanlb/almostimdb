# frozen_string_literal: true

class Api::V1::CastController < ApiController
  SERIALIZER_OPTIONS = {
    include:  [:directors, :producers, :casting]
  }.freeze

  before_action :authorize_request, except: [:index]
  before_action :set_movie
  before_action :set_cast, only: [:destroy]

  def index
    render json: PersonResumedSerializer.new(@movie.casting).serializable_hash
  end

  def create
    cast = Cast.new(cast_params)
    cast.movie = @movie
    if cast.save
      render json: MovieSerializer.new(@movie, SERIALIZER_OPTIONS).serializable_hash
    else
      render json: cast.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cast.destroy
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_cast
    @cast = @movie.casts.find_by!(person_id: params[:id])
  end

  def cast_params
    params.require(:cast).permit(:person_id)
  end
end

# frozen_string_literal: true

class Api::V1::ProducersController < ApiController
  SERIALIZER_OPTIONS = {
    include:  [:directors, :producers, :casting]
  }.freeze

  before_action :authorize_request, except: [:index]
  before_action :set_movie
  before_action :set_production, only: [:destroy]

  def index
    render json: PersonResumedSerializer.new(@movie.producers).serializable_hash
  end

  def create
    production = Production.new(production_params)
    production.movie = @movie
    if production.save
      render json: MovieSerializer.new(@movie, SERIALIZER_OPTIONS).serializable_hash
    else
      render json: production.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @production.destroy
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_production
    @production = @movie.productions.find_by!(person_id: params[:id])
  end

  def production_params
    params.require(:producer).permit(:person_id)
  end
end

# frozen_string_literal: true

class Api::V1::CastController < ApiController
  before_action :set_movie
  def index
    render json: PersonResumedSerializer.new(@movie.casting).serializable_hash
  end

    private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end

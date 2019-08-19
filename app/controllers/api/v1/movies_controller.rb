# frozen_string_literal: true

class Api::V1::MoviesController < ApiController
  def index
    render json: MovieSerializer.new(Movie.all).serializable_hash
  end
end

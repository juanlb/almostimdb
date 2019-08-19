# frozen_string_literal: true

class Api::V1::MoviesController < ApiController
  def index
    options = {}
    options[:include] = [:directors, :producers, :casting]
    render json: MovieSerializer.new(Movie.all, options).serializable_hash
  end
end

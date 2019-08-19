# frozen_string_literal: true

class Api::V1::MoviesController < ApiController
  SERIALIZER_OPTIONS = {
    include: [:directors, :producers, :casting]
  }.freeze

  before_action :set_movie, only: [:show, :update, :destroy]

  def index
    render json: MovieSerializer.new(Movie.all, SERIALIZER_OPTIONS).serializable_hash
  end

  def show
    render json: MovieSerializer.new(@movie, SERIALIZER_OPTIONS).serializable_hash
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render json: MovieSerializer.new(@movie, SERIALIZER_OPTIONS).serializable_hash
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      render json: MovieSerializer.new(@movie, SERIALIZER_OPTIONS).serializable_hash
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :release_year)
  end
end

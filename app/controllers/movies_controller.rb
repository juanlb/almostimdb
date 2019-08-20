class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :destroy, :edit, :update, :director, :producer, :cast, :destroy_director, :destroy_producer, :destroy_cast]
  before_action :set_fullpage, only: [:index]
  before_action :set_available_directors, only: [:show]
  before_action :set_available_producers, only: [:show]
  before_action :set_available_casting, only: [:show]

  def index
    @movies = Movie.all
  end

  def show
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, notice: 'Movie was successfully destroyed.'
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def director
    Direction.create(movie_id: @movie.id, person_id: person_params[:person_id])
    redirect_to @movie, notice: 'Director added.'
  end

  def producer
    Production.create(movie_id: @movie.id, person_id: person_params[:person_id])
    redirect_to @movie, notice: 'Producer added.'
  end

  def cast
    Cast.create(movie_id: @movie.id, person_id: person_params[:person_id])
    redirect_to @movie, notice: 'Cast added.'
  end

  def destroy_director
    Direction.find(params[:director_id]).destroy
    redirect_to @movie, notice: 'Director removed.'
  end

  def destroy_producer
    Production.find(params[:producer_id]).destroy
    redirect_to @movie, notice: 'Producer removed.'
  end

  def destroy_cast
    Cast.find(params[:cast_id]).destroy
    redirect_to @movie, notice: 'Cast removed.'
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :release_year)
  end

  def person_params
    params.permit(:person_id)
  end

  def set_available_directors
    @available_directors = Person.where.not(id: @movie.directors)
  end

  def set_available_producers
    @available_producers = Person.where.not(id: @movie.producers)
  end

  def set_available_casting
    @available_casting = Person.where.not(id: @movie.casting)
  end
end

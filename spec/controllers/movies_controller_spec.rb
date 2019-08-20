# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  login_user

  let(:valid_attributes) do
    { title: 'Terminator', release_year: 2000 }
  end

  let(:invalid_attributes) do
    { title: 'Terminator', release_year: nil }
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let!(:movie) { create(:movie) }
    it 'returns http success' do
      get :show, params: { id: movie.to_param }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'post #director' do
    let!(:movie) { create(:movie) }
    let!(:person) { create(:person) }
    it 'returns http success' do
      post :director, params: { id: movie.to_param, person_id: person.id }
      expect(response).to redirect_to(movie)
    end
  end

  describe 'post #producer' do
    let!(:movie) { create(:movie) }
    let!(:person) { create(:person) }
    it 'returns http success' do
      post :producer, params: { id: movie.to_param, person_id: person.id }
      expect(response).to redirect_to(movie)
    end
  end

  describe 'post #cast' do
    let!(:movie) { create(:movie) }
    let!(:person) { create(:person) }
    it 'returns http success' do
      post :cast, params: { id: movie.to_param, person_id: person.id }
      expect(response).to redirect_to(movie)
    end
  end

  describe 'delete #destroy_director' do
    let!(:direction) { create(:direction) }
    it 'returns http success' do
      delete :destroy_director, params: { id: direction.movie.to_param, director_id: direction.id }
      expect(response).to redirect_to(direction.movie)
    end
  end

  describe 'delete #destroy_producer' do
    let!(:production) { create(:production) }
    it 'returns http success' do
      delete :destroy_producer, params: { id: production.movie.to_param, producer_id: production.id }
      expect(response).to redirect_to(production.movie)
    end
  end

  describe 'delete #destroy_cast' do
    let!(:cast) { create(:cast) }
    it 'returns http success' do
      delete :destroy_cast, params: { id: cast.movie.to_param, cast_id: cast.id }
      expect(response).to redirect_to(cast.movie)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    let!(:movie) { create(:movie) }
    it 'redirects to the movies list' do
      delete :destroy, params: { id: movie.to_param }
      expect(response).to redirect_to(movies_url)
    end
  end

  describe 'PUT #update' do
    context 'valid parameters' do
      let!(:movie) { create(:movie) }
      it 'returns http success' do
        put :update, params: { id: movie.to_param, movie: valid_attributes }
        expect(response).to redirect_to(movie)
      end
    end
    context 'invalid parameters' do
      let!(:movie) { create(:movie) }
      it 'returns http success' do
        put :update, params: { id: movie.to_param, movie: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'valid parameters' do
      it 'returns http success' do
        post :create, params: { movie: valid_attributes }
        expect(response).to redirect_to(Movie.last)
      end
    end
    context 'invalid parameters' do
      it 'returns http success' do
        post :create, params: {  movie: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end

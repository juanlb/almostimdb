# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  login_user
  describe 'GET #index' do
    let!(:movie) { create(:movie, title: 'A Title') }
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns movie array' do
      get :index
      expect(JSON.parse(response.body)['data'].first['attributes']['title']).to eq movie.title
    end
  end

  describe 'GET #show' do
    let!(:movie) { create(:movie) }
    it 'returns http success' do
      get :show, params: { id: movie.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    before { request.headers.merge!('Authorization' => "Bearer #{valid_jwt}") }
    context 'all the parameters' do
      it 'returns http success' do
        post :create, params: { movie: { title: 'New Film', release_year: 1990 } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'without all parameters' do
      it 'returns http unprocessable_entity' do
        post :create, params: { movie: { title: 'New Film' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    before { request.headers.merge!('Authorization' => "Bearer #{valid_jwt}") }
    let!(:movie) { create(:movie) }
    context 'all the parameters' do
      it 'returns http success' do
        put :update, params: { id: movie.id, movie: { title: 'New Film', release_year: 1990 } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'without all parameters' do
      it 'returns http unprocessable_entity' do
        put :update, params: {  id: movie.id, movie: { title: 'New Film', release_year: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  
    context 'with wrong id' do
      it 'returns http not_found' do
        put :update, params: {  id: -1, movie: { title: 'New Film', release_year: nil } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { request.headers.merge!('Authorization' => "Bearer #{valid_jwt}") }
    let!(:movie) { create(:movie) }
    context 'all the parameters' do
      it 'returns http success' do
        delete :destroy, params: { id: movie.id}
        expect(response).to have_http_status(:success)
      end
    end

    context 'with wrong id' do
      it 'returns http not_found' do
        delete :destroy, params: {  id: -1}
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  def valid_jwt
    payload = {
      user_id: User.first.id
    }
    JsonWebToken.encode(payload)
  end
end
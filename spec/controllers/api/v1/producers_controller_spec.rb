# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProducersController, type: :controller do
  login_user
  describe 'GET #index' do
    let!(:production) { create(:production) }
    it 'returns http success' do
      get :index, params: { movie_id: production.movie_id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    before { request.headers.merge!('Authorization' => "Bearer #{valid_jwt}") }
    context 'with valid params' do
      let!(:movie) { create(:movie) }
      let!(:person) { create(:person) }

      it 'returns http success' do
        post :create, params: { movie_id: movie.id, producer: { person_id: person.id } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with exising relation' do
      let!(:production) { create(:production) }
      it 'fails on creation' do
        post :create, params: { movie_id: production.movie_id, producer: { person_id: production.person_id } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { request.headers.merge!('Authorization' => "Bearer #{valid_jwt}") }
    context 'existing record' do
      let!(:production) { create(:production) }
      it 'returns http success' do
        delete :destroy, params: { movie_id: production.movie_id, id: production.person_id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'unexisting record' do
        let!(:production) { create(:production) }
        it 'returns http not_found' do
          delete :destroy, params: { movie_id: production.movie_id, id: -1 }
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

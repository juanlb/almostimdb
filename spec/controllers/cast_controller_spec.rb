# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CastController, type: :controller do
  describe 'GET #index' do
    let!(:cast) { create(:cast) }
    it 'returns http success' do
      get :index, params: { movie_id: cast.movie_id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let!(:movie) { create(:movie) }
      let!(:person) { create(:person) }

      it 'returns http success' do
        post :create, params: { movie_id: movie.id, cast: { person_id: person.id } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with exising relation' do
      let!(:cast) { create(:cast) }
      it 'fails on creation' do
        post :create, params: { movie_id: cast.movie_id, cast: { person_id: cast.person_id } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'existing record' do
      let!(:cast) { create(:cast) }
      it 'returns http success' do
        delete :destroy, params: { movie_id: cast.movie_id, id: cast.person_id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'unexisting record' do
        let!(:cast) { create(:cast) }
        it 'returns http not_found' do
          delete :destroy, params: { movie_id: cast.movie_id, id: -1 }
          expect(response).to have_http_status(:not_found)
        end
      end
  end
end

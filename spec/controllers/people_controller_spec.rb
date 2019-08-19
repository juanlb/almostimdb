# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PeopleController, type: :controller do
  describe 'GET #index' do
    let!(:person) { create(:person, first_name: 'John', last_name: 'Doe') }
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns people array' do
        get :index
        expect(JSON.parse(response.body)['data'].first['attributes']['full_name']).to eq "#{person.first_name} #{person.last_name} (#{person.aliases})"
      end
  end

  describe 'GET #show' do
    let!(:person) { create(:person) }
    it 'returns http success' do
      get :show, params: {id: person.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'all the parameters' do
      it 'returns http success' do
        post :create, params: { person: { first_name: 'John', last_name: "Doe" } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'without all parameters' do
      it 'returns http unprocessable_entity' do
        post :create, params: { person: { first_name: 'John' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let!(:person) { create(:person) }
    context 'all the parameters' do
      it 'returns http success' do
        put :update, params: { id: person.id, person: { first_name: 'John', last_name: "Doe" } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'without all parameters' do
      it 'returns http unprocessable_entity' do
        put :update, params: {  id: person.id, person: { first_name: 'John', last_name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with wrong id' do
      it 'returns http not_found' do
        put :update, params: {  id: -1, person: { first_name: 'John', last_name: "Doe" } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:person) { create(:person) }
    context 'all the parameters' do
      it 'returns http success' do
        delete :destroy, params: { id: person.id}
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
end

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
    let!(:person) { create(:person, first_name: 'John', last_name: 'Doe') }
    it 'returns http success' do
      get :show, params: {id: person.id}
      expect(response).to have_http_status(:success)
    end
  end
end

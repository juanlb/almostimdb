# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  describe 'GET #index' do
    let!(:movie) { create(:movie, title: 'A Title')}
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns movie array' do
      get :index
      expect(JSON.parse(response.body).first['title']).to eq movie.title
    end
  end
end

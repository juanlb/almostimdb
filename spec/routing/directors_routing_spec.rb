# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DirectorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/movies/1/directors').to route_to('api/v1/directors#index', movie_id: '1')
    end
    
    it 'routes to #create' do
      expect(post: '/api/v1/movies/1/directors').to route_to('api/v1/directors#create', movie_id: '1')
    end
    
    it 'routes to #destroy' do
      expect(delete: '/api/v1/movies/1/directors/1').to route_to('api/v1/directors#destroy', movie_id: '1', id: '1')
    end
  end
end

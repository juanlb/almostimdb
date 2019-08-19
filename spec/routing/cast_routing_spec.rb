# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CastController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/movies/1/cast').to route_to('api/v1/cast#index', movie_id: '1')
    end
    
    it 'routes to #create' do
      expect(post: '/api/v1/movies/1/cast').to route_to('api/v1/cast#create', movie_id: '1')
    end
    
    it 'routes to #destroy' do
      expect(delete: '/api/v1/movies/1/cast/1').to route_to('api/v1/cast#destroy', movie_id: '1', id: '1')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProducersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/movies/1/producers').to route_to('api/v1/producers#index', movie_id: '1')
    end
    
    it 'routes to #create' do
      expect(post: '/api/v1/movies/1/producers').to route_to('api/v1/producers#create', movie_id: '1')
    end
    
    it 'routes to #destroy' do
      expect(delete: '/api/v1/movies/1/producers/1').to route_to('api/v1/producers#destroy', movie_id: '1', id: '1')
    end
  end
end

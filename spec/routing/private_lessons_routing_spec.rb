require 'spec_helper'

describe PrivateLessonsController do
  describe 'routing' do
    it 'routes to #index' do
      get('/private_lessons').should route_to('private_lessons#index')
    end

    it 'routes to #new' do
      get('/private_lessons/new').should route_to('private_lessons#new')
    end

    it 'routes to #show' do
      get('/private_lessons/1')
      .should route_to('private_lessons#show', id: '1')
    end

    it 'routes to #edit' do
      get('/private_lessons/1/edit')
      .should route_to('private_lessons#edit', id: '1')
    end

    it 'routes to #create' do
      post('/private_lessons').should route_to('private_lessons#create')
    end

    it 'routes to #update' do
      put('/private_lessons/1')
      .should route_to('private_lessons#update', id: '1')
    end

    it 'routes to #destroy' do
      delete('/private_lessons/1')
      .should route_to('private_lessons#destroy', id: '1')
    end
  end
end

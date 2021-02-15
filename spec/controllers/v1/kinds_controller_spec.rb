require 'rails_helper'

describe V1::KindsController, type: :controller do
  context 'request index' do
    it 'and return 200 OK' do
      request.accept = 'application/vnd.api+json'
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'with no accept header' do
      get :index
      expect(response).to have_http_status(:not_acceptable)
    end
  end

  context 'request show' do
    it 'and return 200 OK' do
      kind = create(:kind)
      request.accept = 'application/vnd.api+json'
      get :show, params: { id: kind.id }
      expect(response).to have_http_status(:ok)
    end
    it 'and return kind' do
      kind = create(:kind, description: 'Amigos')
      request.accept = 'application/vnd.api+json'

      get :show, params: { id: kind.id }
      response_data = JSON.parse(response.body).fetch('data')

      expect(response_data.fetch('attributes').fetch('description'))
        .to eql('Amigos')
      expect(response_data.fetch('type')).to eql('kinds')
      expect(response_data.fetch('id')).to eql(kind.id.to_s)
    end
    it 'with no kind' do
      Kind.destroy_all
      request.accept = 'application/vnd.api+json'

      get :show, params: { id: 1 }

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'request create' do
    it 'and create kind' do
      params = {
        'data': {
          'type': 'kinds',
          'attributes': {
            'description': 'Familia'
          }
        }
      }

      request.accept = 'application/vnd.api+json'
      post :create, params: params

      kind = Kind.last
      expect(response).to have_http_status(:created)
      expect(kind.description).to eql('Familia')
    end
    it 'with no params' do
      request.accept = 'application/vnd.api+json'
      post :create, params: nil

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'request update' do
    it 'and update kind' do
      kind = create(:kind, description: 'Amigos')
      params = {
        'id': kind.id,
        'data': {
          'id': kind.id.to_s,
          'type': 'kinds',
          'attributes': {
            'description': 'Familia'
          }
        }
      }

      request.accept = 'application/vnd.api+json'
      patch :update, params: params

      kind.reload
      expect(response).to have_http_status(:ok)
      expect(kind.description).to eql('Familia')
    end
    it 'with no kind' do
      Kind.destroy_all
      params = {
        'id': 1,
        'data': {
          'id': '1',
          'type': 'kinds',
          'attributes': {
            'description': 'Familia'
          }
        }
      }
      request.accept = 'application/vnd.api+json'
      patch :update, params: params

      expect(response).to have_http_status(:not_found)
    end
    it 'with wrong params' do
      kind = create(:kind, description: 'Amigos')
      params = {
        'id': kind.id,
        'data': {
          'id': kind.id.to_s,
          'type': 'kinds',
          'attributes': {
            'description': ''
          }
        }
      }
      request.accept = 'application/vnd.api+json'
      patch :update, params: params

      kind.reload
      expect(response).to have_http_status(:unprocessable_entity)
      expect(kind.description).to eql('Amigos')
    end
  end

  context 'request destroy' do
    it 'and destroy kind' do
      Kind.destroy_all
      kind = create(:kind)

      request.accept = 'application/vnd.api+json'
      delete :destroy, params: { id: kind.id }

      expect(response).to have_http_status(:no_content)
      expect(Kind.all.count).to eql(0)
    end
    it 'with no kind' do
      Kind.destroy_all

      request.accept = 'application/vnd.api+json'
      delete :destroy, params: { id: 1 }

      expect(response).to have_http_status(:not_found)
      expect(Kind.all.count).to eql(0)
    end
    it 'with wrong id' do
      Kind.destroy_all
      kind = create(:kind)
      request.accept = 'application/vnd.api+json'
      delete :destroy, params: { id: (kind.id + 1) }

      expect(response).to have_http_status(:not_found)
      expect(Kind.last).to eql(kind)
    end
  end
end

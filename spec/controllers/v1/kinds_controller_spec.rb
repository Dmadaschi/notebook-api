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

  # context 'request show' do
  #   it 'and return 200 OK' do
  #     request.accept = 'application/vnd.api+json'
  #     get :show
  #     expect(response).to have_http_status(:ok)
  #   end
  #   it 'with no accept header' do
  #     get :show
  #     expect(response).to have_http_status(:not_acceptable)
  #   end
  # end
end

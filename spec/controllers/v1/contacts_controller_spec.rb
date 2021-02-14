require 'rails_helper'

describe V1::ContactsController, type: :controller do
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
      contact = create(:contact)
      request.accept = 'application/vnd.api+json'

      get :show, params: { id: contact.id }

      expect(response).to have_http_status(:ok)
    end
    it 'and return contact' do
      contact = create(:contact)
      request.accept = 'application/vnd.api+json'

      get :show, params: { id: contact.id }
      response_data = JSON.parse(response.body).fetch('data')

      expect(response_data.fetch('type')).to eq('contacts')
      expect(response_data.fetch('id')).to eq(contact.id.to_s)
      expect(response_data.fetch('attributes').fetch('name'))
        .to eq(contact.name.to_s)
      expect(response_data.fetch('attributes').fetch('email'))
        .to eq(contact.email.to_s)
      expect(response_data.fetch('attributes').fetch('birthdate'))
        .to eq(contact.birthdate.to_time.iso8601.to_s)
    end

    it 'with no contact' do
      request.accept = 'application/vnd.api+json'

      get :show, params: { id: '1' }

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("Couldn't find Contact with 'id'=1")
    end
  end

  context 'request create' do
    it 'and create contact' do
      kind = create(:kind)
      params = {
        'data': {
          'type': 'contacts',
          'attributes': {
            'name': 'José',
            'email': 'jose@jose.com.br',
            'birthdate': '03/10/2010'
          },
          'relationships': {
            'kind': {
              'data': {
                'id': kind.id.to_s,
                'type': 'kinds'
              }
            }
          }
        }
      }

      request.accept = 'application/vnd.api+json'
      get :create, params: params
      contact = Contact.last

      expect(response).to have_http_status(:created)
      expect(contact.name).to eql('José')
      expect(contact.email).to eql('jose@jose.com.br')
      expect(I18n.l(contact.birthdate)).to eql('03/10/2010')
      expect(contact.kind).to eql(kind)
    end
  end
end

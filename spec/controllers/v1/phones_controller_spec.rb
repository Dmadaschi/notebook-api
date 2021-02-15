require 'rails_helper'

describe V1::PhonesController, type: :controller do
  context 'request show' do
    it 'and return 200 OK' do
      phone = create(:phone)

      request.accept = 'application/vnd.api+json'
      get :show, params: { contact_id: phone.contact.id }

      expect(response).to have_http_status(:ok)
    end
    it 'with no accept header' do
      phone = create(:phone)

      get :show, params: { contact_id: phone.contact.id }

      expect(response).to have_http_status(:not_acceptable)
    end
    it 'and return phone' do
      phone = create(:phone, number: '(11) 555-9133')
      request.accept = 'application/vnd.api+json'

      get :show, params: { contact_id: phone.contact.id }

      response_data = JSON.parse(response.body).fetch('data')
      expect(response_data.first.fetch('id')).to eql(phone.id.to_s)
      expect(response_data.first.fetch('type')).to eql('phones')
      expect(response_data.first.fetch('attributes').fetch('number'))
        .to eql('(11) 555-9133')
      expect(response_data.first.fetch('relationships').fetch('contact')
                          .fetch('data').fetch('id'))
        .to eql(phone.contact.id.to_s)
    end
    it 'with no phone' do
      Phone.destroy_all
      request.accept = 'application/vnd.api+json'

      get :show, params: { contact_id: '1' }

      expect(response).to have_http_status(:not_found)
    end
    it 'with multiple phones' do
      Phone.destroy_all
      contact = create(:contact)
      phones = create_list(:phone, 2, contact: contact)
      request.accept = 'application/vnd.api+json'

      get :show, params: { contact_id: contact.id }

      response_data = JSON.parse(response.body).fetch('data')
      expect(response_data.count).to eql(2)
      expect(response_data.first.fetch('id')).to eql(phones.first.id.to_s)
      expect(response_data.second.fetch('id')).to eql(phones.second.id.to_s)
      expect(response_data.first.fetch('relationships').fetch('contact')
                          .fetch('data').fetch('id'))
        .to eql(contact.id.to_s)
      expect(response_data.second.fetch('relationships').fetch('contact')
                          .fetch('data').fetch('id'))
        .to eql(contact.id.to_s)
    end
  end
end

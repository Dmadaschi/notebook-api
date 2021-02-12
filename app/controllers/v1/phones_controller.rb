module V1
  class PhonesController < ApplicationController
    before_action :set_contact, only: %i[show update create destroy]

    def show
      render json: @contact.phones
    end

    def create
      @contact.phones.build(phone_params)

      if @contact.save
        render json: @contact.phones, status: :created,
              location: contact_phones_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    def destroy
      Phone.find(phone_params[:id]).destroy
    end

    def update
      phone = Phone.find(phone_params[:id])

      if phone.update(phone_params)
        render json: @contact.phones, status: :created,
              location: contact_phones_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    private

    def phone_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(
        params, only: %i[number id]
      )
    end

    def set_contact
      @contact = Contact.find(params[:contact_id])
    end
  end
end

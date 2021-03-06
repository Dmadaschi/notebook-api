module V1
  class ContactsController < ApplicationController
    before_action :set_contact, only: %i[show update destroy]

    def index
      @contacts = Contact.all.page(params[:page].try(:[], :number))
                         .per(params[:page].try(:[], :size))

      render json: @contacts
    end

    def show
      render json: @contact
    end

    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, status: :created
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    def update
      if @contact.update(contact_params)
        render json: @contact, include: %i[kind phones address]
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @contact.destroy
      render json: nil, status: :ok
    end

    private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(
        params, only: %i[name email birthdate kind phone address]
      )
    end
  end
end

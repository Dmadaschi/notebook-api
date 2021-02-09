class AddressesController < ApplicationController
  before_action :set_contact, only: %i[show update create destroy]

  def show
    render json: @contact.address
  end

  def update
    if @contact.update(address_params)
      render json: @contact.address
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.address.destroy
  end

  def create
    @contact.build_address(address_params)

    if @contact.save
      render json: @contact.address, status: :created,
             location: contact_address_url(@contact)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  private

  def address_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params, only: %i[street city]
    )
  end

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end
end

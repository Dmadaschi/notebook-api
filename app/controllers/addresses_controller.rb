class AddressesController < ApplicationController
  def show
    set_address
    render json: @address
  end

  private

  def set_address
    @address = Contact.find(params[:contact_id]).address
  end
end

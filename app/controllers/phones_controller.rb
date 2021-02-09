class PhonesController < ApplicationController
  def show
    set_phones
    render json: @phones
  end

  private

  def set_phones
    @phones = Contact.find(params[:contact_id]).phones
  end
end

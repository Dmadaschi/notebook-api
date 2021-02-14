class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :ensure_json_request
  # before_action :authenticate_user!

  private

  def ensure_json_request
    return if request.headers['Accept'] =~ /json/

    render nothing: true, status: 406
  end

  def record_not_found(exeption)
    render json: exeption, status: :not_found
  end
end

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :ensure_json_request
  # before_action :authenticate_user!

  def ensure_json_request
    return if request.headers['Accept'] =~ /json/

    render nothing: true, status: 406
  end
end

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?
  # disable wrapper so the request is not wrapped into a :registration object since it's not needed with devise_token_auth 
  wrap_parameters false, if: :devise_controller?

  private

  def configure_permitted_parameters
    # for user account creation i.e sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :image, :phone_number])
    # for user account update
    # where bank_name and bank_account are nested attributes in the User model
    # devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, bank_attributes: [:bank_name, :bank_account]])
  end
end
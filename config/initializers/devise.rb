Devise.setup do |config|
  # needed cause it's not implemented for devise_token_auth and it does a duplicate validation if added into app/models/user.rb
  config.password_length = 12..64
end
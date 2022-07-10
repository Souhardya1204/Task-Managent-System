# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.GOOGLE_CLIENT_ID,
           Rails.application.credentials.GOOGLE_CLIENT_SECRET, { access_type: "offline" }
  provider :facebook, Rails.application.credentials.FACEBOOK_APP_ID, Rails.application.credentials.FACEBOOK_APP_SECRET
end
OmniAuth.config.allowed_request_methods = %i[get]

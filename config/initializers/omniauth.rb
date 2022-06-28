Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2,ENV['GOOGLE_CLIENT_ID'],ENV['GOOGLE_CLIENT_SECRET'], {  access_type: 'offline'}
    provider :facebook, '553596949725333', 'eab9c3b0ab06859c1f5db638e371e7dc'
end
OmniAuth.config.allowed_request_methods = %i[get]

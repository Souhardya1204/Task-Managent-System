Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2,'486324289510-mvmo40actkrsvgh4v0q3665sngkun0ll.apps.googleusercontent.com','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', {  access_type: 'offline'}
    provider :facebook, '553596949725333', 'eab9c3b0ab06859c1f5db638e371e7dc'
end
OmniAuth.config.allowed_request_methods = %i[get]

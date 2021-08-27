Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github, 'client_id', 'client_secret',
             provider_ignores_state: true
  else
    provider :github,
             Rails.application.credentials.github[:client_id],
             Rails.application.credentials.github[:client_secret]
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'WKEMaXYkT7prX2kdCYKyuw', 'GYreNZWU9fNcDWTEE1oWZRPwhVxS5C2UV5wWrm3HQc'
  #provider :facebook, 'APP_ID', 'APP_SECRET'
end
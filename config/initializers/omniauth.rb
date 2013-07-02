Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'WKEMaXYkT7prX2kdCYKyuw', 'GYreNZWU9fNcDWTEE1oWZRPwhVxS5C2UV5wWrm3HQc'
  provider :facebook, '177826365724897', '42fd4861cb678f4de5e1ed1a8d7153e7'
end
require 'pusher'

Pusher.host   = Settings.pusher.api_host
Pusher.port   = Settings.pusher.api_port
# Configure the application.
Pusher.app_id = Settings.pusher.app_id
Pusher.key = Settings.pusher.app_key
Pusher.secret = Settings.pusher.app_secret

Pusher.logger = Rails.logger
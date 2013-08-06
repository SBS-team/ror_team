require 'pusher'

Pusher.app_id= '1'
Pusher.key= '765ec374ae0a69f4ce44'
Pusher.secret= '628a05f0fcb9d19f4e8a'
Pusher.host   = '127.0.0.1'
Pusher.port   = 4567

Pusher.logger = Rails.logger
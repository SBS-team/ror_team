require 'pusher'

Pusher.app_id= '1'
Pusher.key= 'c46c644b78f84661ace01b35dffceabc'
Pusher.secret= '15c85d0ce00c492888423aca73f65d19'
Pusher.host   = '127.0.0.1'
Pusher.port   = 4567

Pusher.logger = Rails.logger
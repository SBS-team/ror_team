class NotificationsMailer < ActionMailer::Base
  default :from => 'emailfaceit@gmail.com'
  default :to => 'realnatisk@gmail.com'

  def new_message(message)
    @message = message
    mail(:subject => "RoR_Team.com #{message.email}")
  end
end

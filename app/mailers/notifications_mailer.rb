class NotificationsMailer < ActionMailer::Base
  default :from => 'from@user.com'
  default :to => 'where_to@gmail.com'

  def new_message(message)
    @message = message
    mail(:subject => "RoR_Team.com #{message.email}")
  end
end

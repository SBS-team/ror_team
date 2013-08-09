class NotificationsMailer < ActionMailer::Base
  default :from => Settings.mailer.user_name
  default :to => Settings.mailer.user_name

  def new_message(message)
    @message = message
    mail(:subject => "RoR_Team.com #{message.email}")
  end
end

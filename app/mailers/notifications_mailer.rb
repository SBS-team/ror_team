class NotificationsMailer < ActionMailer::Base

  default from: Settings.mailer.user_name
  default to: Settings.mailer.email_to

  def new_message(message)
    @message = message
    mail(subject: "RoR_Team.com #{message.email}")
  end

end

class EventNotification < ApplicationMailer
  include SendGrid
  default from: "convites@amigox.com"

  def send_email(user, event)
    @user = user
    @event = event

    mail( :to => @user.email, :subject => "Você está participando de um novo evento no grupo #{@event.group.name}" )
  end
end

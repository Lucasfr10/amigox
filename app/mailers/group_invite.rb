class GroupInvite < ApplicationMailer
  include SendGrid
  default from: "convites@amigox.com"

  def sample_email(user, group)
    @user = user
    @group = group

    mail( :to => @user.email, :subject => "Você recebeu um convite para participar do grupo #{@group.name}" )
  end
end

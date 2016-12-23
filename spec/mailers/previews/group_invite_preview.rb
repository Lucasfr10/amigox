# Preview all emails at http://localhost:3000/rails/mailers/group_invite
class GroupInvitePreview < ActionMailer::Preview
  def sample_mail_preview
    ExampleMailer.sample_email(User.first)
  end
end

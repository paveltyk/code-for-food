class Mailer < ActionMailer::Base
  def invitation(invitation)
    @invitation = invitation
    mail :to => invitation.recipient_email,
         :from => invitation.sender.email,
         :subject => "Your invitation to join \"Code for Food\" meal ordering system"
  end
end


class Mailer < ActionMailer::Base
  def invitation(invitation)
    @invitation = invitation
    mail :to => invitation.recipient_email,
         :from => invitation.sender.email,
         :subject => 'Приглашение для регистрации на сайте code-for-food.info'
  end

  def menu_published(menu)
    @menu = menu
    hdr = SendGrid::ApiHeader.new
    hdr.add_recipients User.all.map(&:email)
    headers['X-SMTPAPI'] = hdr.to_json
    mail :to => 'group-delivery@code-for-food.info',
         :from => 'no-reply@code-for-food.info',
         :subject => "Опубликовано меню на \"#{@menu}\""
  end
end


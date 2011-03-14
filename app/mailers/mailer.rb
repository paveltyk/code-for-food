class Mailer < ActionMailer::Base
  def invitation(invitation)
    @invitation = invitation
    mail :to => invitation.recipient_email,
         :from => invitation.sender.email,
         :subject => 'Приглашение для регистрации на сайте code-for-food.info'
  end

  def menu_published(menu)
    @menu = menu
    @users = User.where(:receive_notifications => true).all
    add_recipients @users.map(&:email)
    substitute '{user_name}', @users.map(&:to_s)
    mail :from => 'no-reply@code-for-food.info',
         :subject => "Опубликовано меню на \"#{@menu}\""
  end
end


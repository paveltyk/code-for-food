class Mailer < ActionMailer::Base
  default :from => ActionMailer::Base.smtp_settings[:user_name]

  def invitation(invitation)
    @invitation = invitation
    category "invitation-#{Rails.env}"

    mail :to => invitation.recipient_email,
         :from => invitation.sender.email,
         :subject => 'Приглашение для регистрации на сайте code-for-food.info'
  end

  def menu_published(menu, users)
    @menu = menu

    category "menu-published-#{Rails.env}"

    mail :bcc => users.map(&:email),
         :subject => "Опубликовано меню на \"#{@menu}\""
  end

  def feedback(feedback)
    category "feedback-#{Rails.env}"

    mail :to => 'paveltyk@code-for-food.info',
         :from => feedback.sender.email,
         :subject => "[Code-for-Food] Feedback from #{feedback.sender}",
         :body => feedback.body
  end

  def password_reset_instruction(user)
    category "password-reset-#{Rails.env}"

    @user = user
    mail :to => @user.email,
         :subject => "[Code-for-Food] Инструкция по восстановлению пароля."
  end

  def question_posted(question, users)
    category "question-posted-#{Rails.env}"
    @question = question

    mail :bcc => users.map(&:email),
         :subject => "[Code-for-Food] #{question.user} что-то спросил..."
  end

  def answer_posted(answer, users)
    category "answer-posted-#{Rails.env}"
    @answer = answer

    mail :bcc => users.map(&:email),
         :subject => "[Code-for-Food] #{answer.user} что-то ответил..."
  end

  protected

  def category(value)
    headers['X-Category'] = value
  end
end


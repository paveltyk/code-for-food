# encoding: utf-8

class Mailer < ActionMailer::Base
  def invitation(invitation)
    @invitation = invitation
    category "invitation-#{Rails.env}"

    mail :to => invitation.recipient_email,
         :from => invitation.sender.email,
         :subject => 'Приглашение для регистрации на сайте code-for-food.info'
  end

  def menu_published(menu)
    @menu = menu
    @users = User.where(:receive_notifications => true).all

    add_recipients @users.map(&:email)
    substitute '{user_name}', @users.map(&:to_s)
    category "menu-published-#{Rails.env}"

    mail :from => 'no-reply@code-for-food.info',
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
         :from => 'no-reply@code-for-food.info',
         :subject => "[Code-for-Food] Инструкция по восстановлению пароля."
  end

  def question_posted(question)
    category "question-posted-#{Rails.env}"
    @question = question
    users = User.where(:receive_forum_notifications => true).all

    add_recipients users.map(&:email)
    substitute '{user_name}', users.map(&:to_s)

    mail :from => 'no-reply@code-for-food.info',
         :subject => "[Code-for-Food] #{question.user} что-то спросил..."
  end

  def answer_posted(answer)
    category "answer-posted-#{Rails.env}"
    @answer = answer

    users = User.where(:receive_forum_notifications => true).all

    add_recipients users.map(&:email)
    substitute '{user_name}', users.map(&:to_s)

    mail :from => 'no-reply@code-for-food.info',
         :subject => "[Code-for-Food] #{answer.user} что-то ответил..."
  end
end


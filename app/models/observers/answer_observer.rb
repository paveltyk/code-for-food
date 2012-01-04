class AnswerObserver < ActiveRecord::Observer
  observe Answer

  def after_create(answer)
    User.where(:receive_forum_notifications => true).all.in_groups_of(20) do |users|
      Mailer.answer_posted(answer, users).deliver
    end
  end
end


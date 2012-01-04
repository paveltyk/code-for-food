class QuestionObserver < ActiveRecord::Observer
  observe Question

  def after_create(question)
    User.where(:receive_forum_notifications => true).all.in_groups_of(20) do |users|
      Mailer.question_posted(question).deliver
    end
  end
end


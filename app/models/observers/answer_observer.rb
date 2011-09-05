# encoding: utf-8

class AnswerObserver < ActiveRecord::Observer
  observe Answer

  def after_create(answer)
    Mailer.answer_posted(answer).deliver
  end
end


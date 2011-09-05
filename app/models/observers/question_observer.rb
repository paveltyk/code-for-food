# encoding: utf-8

class QuestionObserver < ActiveRecord::Observer
  observe Question

  def after_create(question)
    Mailer.question_posted(question).deliver
  end
end


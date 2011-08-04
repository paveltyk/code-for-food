class AnswersController < ApplicationController
  before_filter :require_user
  before_filter :load_question

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.new params[:answer]
    @answer.user = current_user

    if @answer.save
      redirect_to questions_path
    else
      render :action => :new
    end
  end

  private

  def load_question
    @question = Question.find params[:question_id]
  end
end


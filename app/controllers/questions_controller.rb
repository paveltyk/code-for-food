# encoding: utf-8

class QuestionsController < ApplicationController
  before_filter :require_user
  def index
    @questions = Question.order('created_at DESC').includes(:user).all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new params[:question]
    @question.user = current_user

    if @question.save
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
end


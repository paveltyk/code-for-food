class FeedbacksController < ApplicationController
  before_filter :require_user

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.sender = current_user

    if @feedback.deliver
      flash[:notice] = 'Спасибо. Ваше сообщение успешно отправлено администратору.'
      redirect_to :action => :new
    else
      render :action => :new
    end
  end
end


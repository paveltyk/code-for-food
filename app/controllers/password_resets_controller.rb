class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def new
    @email = params[:email]
  end

  def create
    @email = params[:email]
    @user = User.find_by_email(@email)

    if @user
      @user.reset_perishable_token!
      #TODO: https://github.com/rejeep/authlogic-password-reset-tutorial
      #Send email here

      flash[:notice] = "Инструкции по восстановлению пароля успешно отправлена на почтовый ящик #{@email}"
      redirect_to :action => :new
    else
      flash[:error] = "Не удалось найти пользователя с адресом электронной почты #{@email}"
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      UserSession.create(@user)
      flash[:notice] = "Ваш пароль упешно изменен."
      redirect_to root_path
    else
      render :action => :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "Извините. Не удалось найти Вашу учетную запись."
      redirect_to :action => :new
    end
  end

end


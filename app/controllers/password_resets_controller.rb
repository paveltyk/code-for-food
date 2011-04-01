class PasswordResetsController < ApplicationController

  def new
    @email = params[:email]
  end

  def create
    @mail = params[:email]
    @user = User.find_by_email(@email)

    if @user
      @user.reset_perishable_token!
      #TODO: https://github.com/rejeep/authlogic-password-reset-tutorial

      flash[:notice] = "Инструкции по восстановлению пароля успешно отправлены на Ваш почтовый ящик."
      redirect_to root_path
    else
      flash[:error] = "Не удалось найти пользователя с адресом электронной почты #{@email}"
      render :action => 'new'
    end
  end

end


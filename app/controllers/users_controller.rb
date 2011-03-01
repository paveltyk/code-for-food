class UsersController < ApplicationController
  before_filter :require_user, :only => [:edit, :update]
  def new
    @user = User.new :invitation_token => params[:invitation_token]
    @user.email = @user.invitation.recipient_email if @user.invitation
  end

  def create
    @user = User.new params[:user]
    @user.validate_invitation = true
    if @user.save
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:notice] = 'Ваш профиль успешно обновлен.'
      redirect_to :action => :edit
    else
      render :action => :edit
    end
  end
end


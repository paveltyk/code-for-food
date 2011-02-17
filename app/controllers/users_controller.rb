class UsersController < ApplicationController
  def new
    @user = User.new :invitation_token => params[:invitation_token]
    @user.email = @user.invitation.recipient_email if @user.invitation
  end

  def create
    @user = User.new params[:user]
    @user.validate_invitation = true
    if @user.save
      flash[:notice] = 'User created successfully.'
      redirect_to root_url
    else
      render :action => :new
    end
  end
end


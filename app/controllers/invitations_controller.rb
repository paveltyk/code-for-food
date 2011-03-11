class InvitationsController < ApplicationController
  before_filter :require_admin

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = current_user.sent_invitations.build(params[:invitation])

    if @invitation.save
      flash[:notice] = "Приглашение #{@invitation.recipient_email} успешно отправлено."
      redirect_to :action => :new
    else
      render :action => :new
    end
  end
end


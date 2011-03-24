class InvitationsController < ApplicationController
  before_filter :require_admin

  def new
    @invitation = Invitation.new
    load_sent_invitations
  end

  def create
    @invitation = current_user.sent_invitations.build(params[:invitation])

    if @invitation.save
      flash[:notice] = "Приглашение #{@invitation.recipient_email} успешно отправлено."
      redirect_to :action => :new
    else
      load_sent_invitations
      render :action => :new
    end
  end

  def load_sent_invitations
    @invitations = Invitation.includes(:receiver).all
  end

end


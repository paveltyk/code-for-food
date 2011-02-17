class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])

    if @invitation.save
      flash[:notice] = 'Invitation was successfully created.'
      redirect_to :action => :new
    else
      render :action => :new
    end
  end
end


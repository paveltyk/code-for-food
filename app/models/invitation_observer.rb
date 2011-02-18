class InvitationObserver < ActiveRecord::Observer
  observe Invitation

  def after_create(invitation)
    Mailer.invitation(invitation).deliver
  end
end


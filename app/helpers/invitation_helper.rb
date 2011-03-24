module InvitationHelper
  def invitation_status_link(invitation)
    if invitation.discharged?
      "Активировано (#{link_to invitation.receiver, [:admin, invitation.receiver]})".html_safe
    else
      "Ожидание (#{link_to 'переслать', resend_invitation_path(invitation), :method => :put})".html_safe
    end
  end
end


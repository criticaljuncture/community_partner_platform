module InvitationsHelper
  def invitation_status_for(user)
    if user.invitation_accepted?
      content = invitation_accepted(user)
    elsif user.invited_to_sign_up?
      content = invited(user)
    else
      content = not_invited(user)
    end

    content.html_safe
  end

  def invitation_accepted(user)
    'Accepted <br />' + 
      user.invitation_sent_at.to_s(:date_at_time)
  end

  def invited(user)
    'Sent ' +
      user.invitation_sent_at.to_s(:date_at_time) + 
      '<br />' +
      link_to('Resend Invitation', send_invitation_user_path(user.id), method: :post)
  end

  def not_invited(user)
    'Not Sent <br />' +
      link_to('Send Invitation', send_invitation_user_path(user.id), method: :post)
  end
end

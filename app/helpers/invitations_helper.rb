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
    str = 'Accepted <br />'
    str += user.invitation_sent_at < 3.months.ago ?
      user.invitation_sent_at.to_s(:date_at_time_with_year) :
      user.invitation_sent_at.to_s(:date_at_time)
  end

  def invited(user)
    status = 'Sent ' + user.invitation_sent_at.to_s(:date_at_time)

    if can?(:send_invitation, user)
      status = status +
        '<br />' +
        link_to('Resend Invitation', send_invitation_user_path(user.id),
          method: :post)
    end

    status
  end

  def not_invited(user)
    status = 'Not Sent <br />'

    if can?(:send_invitation, user)
      status = status + link_to('Send Invitation', send_invitation_user_path(user.id), method: :post)
    end

    status
  end
end

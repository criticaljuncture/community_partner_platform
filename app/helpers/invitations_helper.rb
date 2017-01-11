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
    str = I18n.t('invitations.accepted')
    str += user.invitation_sent_at < 3.months.ago ?
      user.invitation_sent_at.to_s(:date_at_time_with_year) :
      user.invitation_sent_at.to_s(:date_at_time)
  end

  def invited(user)
    status = I18n.t('invitations.sent', sent_at: user.invitation_sent_at.to_s(:date_at_time))

    if can?(:send_invitation, user)
      status = status +
        '<br />' +
        link_to(I18n.t('invitations.resend'), send_invitation_user_path(user.id),
          method: :post)
    end

    status
  end

  def not_invited(user)
    status = I18n.t('invitations.not_sent')

    if can?(:send_invitation, user)
      status = status + link_to(I18n.t('invitations.send'), send_invitation_user_path(user.id), method: :post)
    end

    status
  end
end

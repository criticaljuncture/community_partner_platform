module VerificationHelper
  def last_verified_tooltip(model)
    if model.last_verified_at.present?
      "Last verified on #{model.last_verified}"
    else
      I18n.t('app.never_verified')
    end
  end
end

class Public::ApplicationController < ApplicationController
  skip_authorization_check
  skip_before_filter :authenticate_user!
  before_filter :redirect_if_no_authentication

  layout 'public/layouts/application.html.erb'

  def redirect_if_no_authentication
    if current_user
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to after_sign_in_path_for(current_user)
    end
  end

end

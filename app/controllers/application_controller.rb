class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # devise
  before_filter :authenticate_user!

  # cancan
  check_authorization :unless => :devise_controller?

  # active model serializers
  serialization_scope :current_user


  def after_sign_in_path_for(user)
    if user.role?(:organization_member) && user.organization.verification_required?
      flash[:notice] = "Welcome. Please verify and complete the information about your organization below."
      Organization.needs_verification_path(user.organization)
    elsif user.role?(:organization_member)
      organization_path(user.organization)
    else
      root_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    if Rails.env.development?
      raise [current_user, current_ability, exception].inspect
    else
      redirect_to root_url, :alert => exception.message
    end
  end

  def info_for_paper_trail
    { current_user_id: current_user.try(:id) }
  end

  before_filter do
    Honeybadger.context({
      :user_id => current_user.id,
      :user_email => current_user.email
    }) if current_user

    Honeybadger.context({
      :subdomain => request.subdomain
    })
  end

  # Peek
  def peek_enabled?
    false
    #can?(:view, :debug_toolbar)
  end

  if defined?(Peek) && Rails.env.development?
    Peek::ResultsController.send(:skip_authorization_check)
  end

  # Rack Mini-Profiler
  def authorize
    if can?(:view, :debug_toolbar)
      Rack::MiniProfiler.authorize_request
    end
  end

  private

  def add_flash_js(key, value)
    flash[:js] = {} if flash[:js].nil?

    flash[:js][key] = value
  end
end

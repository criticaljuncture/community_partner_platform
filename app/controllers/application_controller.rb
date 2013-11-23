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
    can?(:view, :debug_toolbar)
  end

  if Rails.env.development?
    Peek::ResultsController.send(:skip_authorization_check)
  end

  # Rack Mini-Profiler
  def authorize
    if can?(:view, :debug_toolbar)
      Rack::MiniProfiler.authorize_request
    end
  end
end

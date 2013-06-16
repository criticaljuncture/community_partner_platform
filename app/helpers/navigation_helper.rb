module NavigationHelper
  def active_for_controller(name)
    return 'active' if params[:controller] == name
  end
end

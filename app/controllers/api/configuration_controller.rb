class Api::ConfigurationController < ApiController
  def school_map
    render json: Settings.app_config.school_map.to_json
  end
end

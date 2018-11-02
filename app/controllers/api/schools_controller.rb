class Api::SchoolsController < ApiController
  def map_markers
    valid_site_types = Settings.app_config.school_map.layers.map(&:name)
    unless valid_site_types.include?(params[:site_type])
      render text: nil and return
    end

    site_types = Settings.app_config.school_map.layers
      .find{|l| l.name == params[:site_type]}
      .site_types

    @schools = School.where(
      site_type_norm: site_types
    ).includes(school_programs: {community_program: :quality_element})

    render json: GeoJsonSerializer.new(@schools, {serializer: CommunityProgramMarkerSerializer})
  end
end

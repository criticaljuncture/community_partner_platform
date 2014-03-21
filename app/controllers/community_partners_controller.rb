class CommunityPartnersController < ApplicationController
  def index
    @community_partners = CommunityPartner.accessible_by(current_ability).includes(:organization).order("organizations.name")
  end

  def show
    @community_partner = CommunityPartner.find(params[:id])
    authorize! :show, @community_partner
  end

  def new
    @community_partner = CommunityPartner.new(community_partner_params)
    authorize! :new, @community_partner

    @community_partner.build_primary_quality_element
    @community_partner.build_secondary_quality_element
  end

  def create
    @community_partner = CommunityPartner.new(community_partner_params)
    authorize! :create, @community_partner

    @community_partner.save!

    redirect_to community_partner_path(@community_partner)
  rescue ActiveRecord::RecordInvalid
    @community_partner.build_primary_quality_element unless @community_partner.primary_quality_element
    @community_partner.build_secondary_quality_element unless @community_partner.secondary_quality_element

    render :new
  end

  def edit
    @community_partner = CommunityPartner.find(params[:id])
    authorize! :edit, @community_partner

    @community_partner.build_secondary_quality_element unless @community_partner.secondary_quality_element.present?
  end

  def update
    @community_partner = CommunityPartner.find(params[:id])
    authorize! :update, @community_partner

    @community_partner.update_attributes!(community_partner_params)

    redirect_to community_partner_path(@community_partner)
  rescue ActiveRecord::RecordInvalid
    @community_partner.build_primary_quality_element unless @community_partner.primary_quality_element
    @community_partner.build_secondary_quality_element unless @community_partner.secondary_quality_element

    render :edit
  end

  private

  def community_partner_params
    params.require(:community_partner).permit(:mou_on_file,
                                              :name,
                                              :notes, 
                                              :organization_id,
                                              :school_id,
                                              :school_user_id,
                                              :secondary_quality_element_id,
                                              :service_description,
                                              :service_time_of_day,
                                              :site_agreement_on_file,
                                              :student_population_id,
                                              :target_population,
                                              :user_id,
                                              day_ids: [],
                                              demographic_group_ids: [],
                                              ethnicity_culture_group_ids: [],
                                              grade_level_ids: [],
                                              primary_quality_element_attributes: [
                                                :id, 
                                                :quality_element_id, 
                                                service_type_ids: []
                                              ],
                                              secondary_quality_element_attributes: [
                                                :id, 
                                                :quality_element_id, 
                                                service_type_ids: []
                                              ],
                                              service_time_ids: []
                                             )
  end
end

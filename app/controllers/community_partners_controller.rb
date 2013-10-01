class CommunityPartnersController < ApplicationController
  authorize_resource
  
  def index
    @community_partners = CommunityPartner.accessible_by(current_ability).includes(:quality_elements, :organization, :service_types).order("organizations.name")
  end

  def show
    @community_partner = CommunityPartner.find(params[:id])
  end

  def new
    @community_partner = CommunityPartner.new
    @community_partner.build_primary_quality_element
    @community_partner.build_secondary_quality_element
  end

  def create
    @community_partner = CommunityPartner.new(community_partner_params)
    @community_partner.save!

    redirect_to community_partner_path(@community_partner)
  rescue ActiveRecord::RecordInvalid
    @community_partner.build_primary_quality_element unless @community_partner.primary_quality_element
    @community_partner.build_secondary_quality_element unless @community_partner.secondary_quality_element

    render :new
  end

  def edit
    @community_partner = CommunityPartner.find(params[:id])
    @community_partner.build_secondary_quality_element unless @community_partner.secondary_quality_element.present?
  end

  def update
    @community_partner = CommunityPartner.find(params[:id])
    @community_partner.update_attributes!(community_partner_params)

    redirect_to community_partner_path(@community_partner)
  rescue ActiveRecord::RecordInvalid
    @community_partner.build_primary_quality_element unless @community_partner.primary_quality_element
    @community_partner.build_secondary_quality_element unless @community_partner.secondary_quality_element

    render :edit
  end

  private

  def community_partner_params
    params.require(:community_partner).permit(:notes, 
                                              :organization_id,
                                              :school_id,
                                              :school_user_id,
                                              :secondary_quality_element_id,
                                              :service_description,
                                              :service_time_of_day,
                                              :site_agreement_on_file,
                                              :target_population,
                                              :user_id,
                                              :community_partner_quality_element_service_type_ids,
                                              primary_quality_element_attributes: [
                                                :id, 
                                                :quality_element_id, 
                                                service_type_ids: []
                                              ],
                                              secondary_quality_element_attributes: [
                                                :id, 
                                                :quality_element_id, 
                                                service_type_ids: []
                                              ]
                                             )
  end
end

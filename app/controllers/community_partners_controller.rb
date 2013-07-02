class CommunityPartnersController < ApplicationController

  def index
    @community_partners = CommunityPartner.includes(:school_quality_indicator_sub_area, :organization, :service_type).order("organizations.name")
  end

  def show
    @community_partner = CommunityPartner.find(params[:id])
  end

  def new
    @community_partner = CommunityPartner.new
  end

  def create
    @community_partner = CommunityPartner.new(community_partner_params)
    @community_partner.save

    redirect_to community_partner_path(@community_partner)
  end

  def edit
    @community_partner = CommunityPartner.find(params[:id])
  end

  def update
    @community_partner = CommunityPartner.find(params[:id])
    @community_partner.update_attributes(community_partner_params)

    redirect_to community_partner_path(@community_partner)
  end

  private

  def community_partner_params
    params.require(:community_partner).permit(:organization_id, :school_id, :school_quality_indicator_sub_area_id, :service_type_id)
  end
end

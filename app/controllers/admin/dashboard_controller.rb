class Admin::DashboardController < Admin::ApplicationController

  def index
    @page_views = PageView.limit(50).where("controller != 'api'").order('id DESC')
    @api_hits = PageView.limit(50).where("controller = 'api'").order('id DESC')
    @organizations = Organization.
      includes(:users).
      order('name').
      map{|organization| OrganizationDecorator.decorate(organization)}
    @all_organizations_program_count  = Organization.with_community_programs.size
    @ousd_organizations_program_count = Organization.ousd.with_community_programs.size
    @community_programs = CommunityProgram.
      includes(:school_programs).
      order('name').
      map{|community_program| CommunityProgramDecorator.decorate(community_program)}

    authorize! :view, :admin_dashboard
  end

end

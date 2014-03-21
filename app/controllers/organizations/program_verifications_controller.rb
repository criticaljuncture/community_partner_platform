class Organizations::ProgramVerificationsController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
    authorize! :verification, @organization
  end

  def create
    counts = params[:school]
    @organization = Organization.find(params[:organization_id])

    authorize! :verification, @organization

    counts.update(counts){|k,v| v.to_i}
    counts.reject!{|k,v| v <= 0 }

    @organization.reported_school_programs = counts
    @organization.save

    flash.notice = "Thank you. Please review your programs in the table below and ensure information is accurate."
    redirect_to organization_path(@organization)
  end
end

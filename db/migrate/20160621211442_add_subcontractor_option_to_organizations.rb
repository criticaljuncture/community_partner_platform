class AddSubcontractorOptionToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :subcontractor_with_lead_agency, :boolean, default: false
  end
end

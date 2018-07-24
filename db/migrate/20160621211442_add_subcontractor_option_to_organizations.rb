class AddSubcontractorOptionToOrganizations < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :subcontractor_with_lead_agency, :boolean, default: false
  end
end

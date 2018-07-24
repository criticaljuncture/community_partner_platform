class AddReportedSchoolProgramsToOrganization < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :reported_school_programs, :text
  end
end

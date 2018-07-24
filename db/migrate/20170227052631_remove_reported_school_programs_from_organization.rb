class RemoveReportedSchoolProgramsFromOrganization < ActiveRecord::Migration[4.2]
  def change
    remove_column :organizations, :reported_school_programs
  end
end

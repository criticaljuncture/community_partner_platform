class RemoveReportedSchoolProgramsFromOrganization < ActiveRecord::Migration
  def change
    remove_column :organizations, :reported_school_programs
  end
end

class AddReportedSchoolProgramsToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :reported_school_programs, :text
  end
end

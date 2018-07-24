class RemoveOldColumnsFromSchoolProgram < ActiveRecord::Migration[4.2]
  def change
    remove_column :school_programs, :service_description
    remove_column :school_programs, :notes
  end
end

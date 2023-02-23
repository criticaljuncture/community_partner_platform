class ConvertSchoolsToLocations < ActiveRecord::Migration[6.1]
  def change
    rename_table :schools, :locations
    add_column :locations, :type, :string, default: "School"
  end
end

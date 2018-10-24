class RemoveOldColumnsFromSchools < ActiveRecord::Migration[5.2]
  def change
    remove_column :schools, :direct_funded_charter_school
    remove_column :schools, :direct_funded_charter_school_number
    remove_column :schools, :network
    remove_column :schools, :net_cluster
  end
end

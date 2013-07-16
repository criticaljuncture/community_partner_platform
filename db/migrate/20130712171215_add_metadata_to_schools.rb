class AddMetadataToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :school_code, :string
   
    add_column :schools, :direct_funded_charter_school, :boolean
    add_column :schools, :direct_funded_charter_school_number, :string

    add_index :schools, :school_code
  end
end

class UpdateSchoolFields < ActiveRecord::Migration
  def change
    rename_column :schools, :school_code, :state_cde_code

    add_column :schools, :site_code, :string
    add_column :schools, :site_type, :string
    add_column :schools, :site_type_norm, :string
    add_column :schools, :address, :string
    add_column :schools, :city, :string
    add_column :schools, :zip_code, :string
    add_column :schools, :grades_served, :string
    add_column :schools, :low_grade, :string
    add_column :schools, :high_grade, :string
    add_column :schools, :lat, :float
    add_column :schools, :lng, :float
    add_column :schools, :network, :string
    add_column :schools, :net_cluster, :string

    add_index :schools, :site_code, unique: true
    add_index :schools, :state_cde_code, unique: true
  end
end

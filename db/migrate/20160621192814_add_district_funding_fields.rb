class AddDistrictFundingFields < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :receives_district_funding, :boolean
    add_column :community_programs, :receives_district_funding, :boolean
  end
end

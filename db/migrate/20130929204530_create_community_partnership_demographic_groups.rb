class CreateCommunityPartnershipDemographicGroups < ActiveRecord::Migration
  def change
    create_table :community_partnership_demographic_groups do |t|
      t.integer :demographic_group_id
      t.integer :community_partner_id
      t.timestamps
    end

    add_index :community_partnership_demographic_groups, [:community_partner_id, :demographic_group_id], name: "cpdg_cpid_dgid"
    add_index :community_partnership_demographic_groups, [:demographic_group_id, :community_partner_id], name: "cpdg_dgid_cpid"
  end
end

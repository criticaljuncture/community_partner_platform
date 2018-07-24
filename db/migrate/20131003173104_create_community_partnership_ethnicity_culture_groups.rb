class CreateCommunityPartnershipEthnicityCultureGroups < ActiveRecord::Migration[4.2]
  def change
    create_table :community_partnership_ethnicity_culture_groups do |t|
      t.integer :community_partner_id
      t.integer :ethnicity_culture_group_id
      t.timestamps
    end

    add_index :community_partnership_ethnicity_culture_groups, [:community_partner_id, :ethnicity_culture_group_id], name: "cpecg_cpid_ecgid"
    add_index :community_partnership_ethnicity_culture_groups, [:ethnicity_culture_group_id, :community_partner_id], name: "cpecg_ecgid_cpid"
  end
end

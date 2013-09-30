class CreateCommunityPartnershipServiceDays < ActiveRecord::Migration
  def change
    create_table :community_partnership_service_days do |t|
      t.integer :community_partner_id
      t.integer :day_id
      t.timestamps
    end

    add_index :community_partnership_service_days, [:community_partner_id, :day_id], name: "cpsd_cpid_did"
    add_index :community_partnership_service_days, [:day_id, :community_partner_id], name: "cpsd_did_cpid"
  end
end

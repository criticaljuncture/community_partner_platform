class CreateCommunityPartnershipServiceTimes < ActiveRecord::Migration[4.2]
  def change
    create_table :community_partnership_service_times do |t|
      t.integer :community_partner_id
      t.integer :service_time_id
      t.timestamps
    end

    add_index :community_partnership_service_times, [:community_partner_id, :service_time_id], name: "cpst_cpid_stid"
    add_index :community_partnership_service_times, [:service_time_id, :community_partner_id], name: "cpst_stid_cpid"
  end
end

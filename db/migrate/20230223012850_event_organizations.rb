class EventOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :event_organizations do |t|
      t.integer :event_id
      t.integer :organization_id
      t.timestamps
    end

    add_index :event_organizations, [:event_id, :organization_id], name: "eo_eid_oid"
    add_index :event_organizations, [:organization_id, :event_id], name: "eo_oid_eid"
  end
end

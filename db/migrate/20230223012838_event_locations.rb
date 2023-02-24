class EventLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :event_locations do |t|
      t.integer :event_id
      t.integer :location_id
      t.timestamps
    end

    add_index :event_locations, [:event_id, :location_id], name: "el_eid_lid"
    add_index :event_locations, [:location_id, :event_id], name: "el_lid_eid"
  end
end

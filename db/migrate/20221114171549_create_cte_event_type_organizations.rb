class CreateCteEventTypeOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :cte_event_type_organizations do |t|
      t.integer :cte_event_type_id
      t.integer :organization_id
      t.timestamps
    end
  end
end

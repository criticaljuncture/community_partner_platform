class CreateCteEventTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :cte_event_types do |t|
      t.string :name
      t.boolean :active, default: true

      t.timestamps
    end
  end
end

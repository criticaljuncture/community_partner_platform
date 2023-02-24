class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :active, default: false
      t.text :notes
      t.timestamps
    end
  end
end

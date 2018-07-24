class CreateServiceTimes < ActiveRecord::Migration[4.2]
  def change
    create_table :service_times do |t|
      t.string :name
      t.timestamps
    end
  end
end

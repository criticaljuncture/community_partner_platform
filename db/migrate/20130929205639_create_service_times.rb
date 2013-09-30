class CreateServiceTimes < ActiveRecord::Migration
  def change
    create_table :service_times do |t|
      t.string :name
      t.timestamps
    end
  end
end

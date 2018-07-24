class CreateDemographicGroups < ActiveRecord::Migration[4.2]
  def change
    create_table :demographic_groups do |t|
      t.string :name
      t.timestamps
    end
  end
end

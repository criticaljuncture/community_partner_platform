class CreateDemographicGroups < ActiveRecord::Migration
  def change
    create_table :demographic_groups do |t|
      t.string :name
      t.timestamps
    end
  end
end

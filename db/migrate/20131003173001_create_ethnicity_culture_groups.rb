class CreateEthnicityCultureGroups < ActiveRecord::Migration
  def change
    create_table :ethnicity_culture_groups do |t|
      t.string :name
      t.timestamps
    end
  end
end

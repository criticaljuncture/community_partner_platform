class CreateEthnicityCultureGroups < ActiveRecord::Migration[4.2]
  def change
    create_table :ethnicity_culture_groups do |t|
      t.string :name
      t.timestamps
    end
  end
end

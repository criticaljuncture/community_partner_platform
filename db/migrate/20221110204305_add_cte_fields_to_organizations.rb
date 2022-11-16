class AddCteFieldsToOrganizations < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :participates_in_cte, :boolean, default: false
  end
end

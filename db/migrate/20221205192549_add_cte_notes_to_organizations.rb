class AddCteNotesToOrganizations < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :cte_notes, :text
  end
end

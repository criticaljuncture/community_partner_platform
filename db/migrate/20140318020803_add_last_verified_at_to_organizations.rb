class AddLastVerifiedAtToOrganizations < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :last_verified_at, :datetime, default: nil
  end
end

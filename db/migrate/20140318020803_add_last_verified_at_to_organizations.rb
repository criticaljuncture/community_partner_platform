class AddLastVerifiedAtToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :last_verified_at, :datetime, default: nil
  end
end

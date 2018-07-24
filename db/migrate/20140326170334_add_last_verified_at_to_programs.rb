class AddLastVerifiedAtToPrograms < ActiveRecord::Migration[4.2]
  def change
    add_column :community_programs, :last_verified_at, :datetime, default: nil
  end
end

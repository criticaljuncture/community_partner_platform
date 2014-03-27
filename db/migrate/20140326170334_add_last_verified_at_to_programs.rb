class AddLastVerifiedAtToPrograms < ActiveRecord::Migration
  def change
    add_column :community_programs, :last_verified_at, :datetime, default: nil
  end
end

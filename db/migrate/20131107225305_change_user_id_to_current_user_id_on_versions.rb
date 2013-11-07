class ChangeUserIdToCurrentUserIdOnVersions < ActiveRecord::Migration
  def change
    rename_column :versions, :user_id, :current_user_id
  end
end

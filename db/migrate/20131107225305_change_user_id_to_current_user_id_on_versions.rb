class ChangeUserIdToCurrentUserIdOnVersions < ActiveRecord::Migration[4.2]
  def change
    rename_column :versions, :user_id, :current_user_id
  end
end

class AddPhoneNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :organization_id, :integer
  end
end

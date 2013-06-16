class AddFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :url, :string

    add_column :organizations, :address, :string
    add_column :organizations, :city, :string
    add_column :organizations, :zip_code, :string

    add_column :organizations, :phone_number, :string

    add_column :organizations, :notes, :text
  end
end

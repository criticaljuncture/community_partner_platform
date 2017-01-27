class ChangeMissingFieldColumnType < ActiveRecord::Migration
  def change
    change_column :community_programs, :missing_fields, :string, limit: 15000, default: '[]'
    change_column :school_programs, :missing_fields, :string, limit: 15000, default: '[]'
    change_column :organizations, :missing_fields, :string, limit: 15000, default: '[]'
  end
end

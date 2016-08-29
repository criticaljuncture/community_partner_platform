class AddMissingFieldsToModelsWithCompletionStatus < ActiveRecord::Migration
  def change
    add_column :community_programs, :missing_fields, :text
    add_column :school_programs, :missing_fields, :text
    add_column :organizations, :missing_fields, :text
  end
end

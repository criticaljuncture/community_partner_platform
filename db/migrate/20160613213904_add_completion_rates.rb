class AddCompletionRates < ActiveRecord::Migration
  def change
    add_column :organizations,      :completion_rate, :float, default: 0
    add_column :community_programs, :completion_rate, :float, default: 0
    add_column :school_programs,    :completion_rate, :float, default: 0
  end
end

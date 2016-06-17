class AddProgramCompletionRates < ActiveRecord::Migration
  def change
    add_column :organizations,      :program_completion_rate, :float
    add_column :community_programs, :program_completion_rate, :float
    add_column :school_programs,    :program_completion_rate, :float
  end
end

class AddSqlQueryIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index :schools, [:active, :direct_funded_charter_school]
    add_index :schools, [:direct_funded_charter_school, :active]

    add_index :community_program_quality_elements,
      [:community_program_id, :type], name: "cpqe_cpi_type"
    add_index :community_program_quality_elements,
      [:type, :community_program_id], name: "cpqe_type_cpi"

    add_index :school_programs, [:active, :community_program_id]
    add_index :school_programs, [:community_program_id, :active]
  end
end

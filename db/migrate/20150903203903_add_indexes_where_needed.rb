class AddIndexesWhereNeeded < ActiveRecord::Migration
  def change
    add_index :page_views, :user_id

    add_index :organizations, :legal_status_id

    add_index :quality_elements, :element_type

    add_index :quality_element_service_types, [:quality_element_id, :service_type_id], name: 'qest_qe_id_st_id'
    add_index :quality_element_service_types, [:service_type_id, :quality_element_id], name: 'qest_st_id_qe_id'

    add_index :school_programs, :student_population_id

    add_index :user_schools, [:school_id, :user_id], name: 'us_s_id_u_id'
    add_index :user_schools, [:user_id, :school_id], name: 'us_u_id_s_id'

    add_index :users, :active
    add_index :users, :invitation_token
    add_index :users, [:invited_by_id, :invited_by_type], name: 'u_ib_id_ib_type'
    add_index :users, [:invited_by_type, :invited_by_id], name: 'u_ib_type_ib_id'
  end
end

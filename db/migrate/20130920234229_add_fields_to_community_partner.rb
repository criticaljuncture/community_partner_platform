class AddFieldsToCommunityPartner < ActiveRecord::Migration
  def change
    add_column :community_partners, :school_user_id, :integer
    add_column :community_partners, :service_description, :text
    add_column :community_partners, :target_population, :string
    add_column :community_partners, :service_time_of_day, :string
    add_column :community_partners, :site_agreement_on_file, :boolean

    add_column :organizations, :mou_on_file, :boolean

    add_column :community_partners, :primary_quality_element_id, :integer
    add_column :community_partners, :primary_service_type_ids, :string
    add_column :community_partners, :secondary_quality_element_id, :integer
    add_column :community_partners, :secondary_service_type_ids, :string

    remove_column :community_partners, :quality_element_id

    add_index :community_partners, :user_id
    add_index :community_partners, :school_user_id
  end
end

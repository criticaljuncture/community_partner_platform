class CreateFreeReducedMealData < ActiveRecord::Migration[4.2]
  def change
    create_table :school_free_reduced_meal_data do |t|
      t.integer   :school_id
      t.datetime  :date
      t.string    :school_year

      t.boolean   :provision_two_three_school
      t.string    :data_source

      t.string    :low_grade
      t.string    :high_grade

      t.integer   :enrollment_k_12
      t.integer   :free_meal_count_k_12
      t.float     :percent_eligible_free_k_12
      t.integer   :frpm_total_undup_count_k_12
      t.float     :frpm_percent_eligible_k_12

      t.integer   :enrollment_5_17
      t.integer   :free_meal_count_5_17
      t.float     :percent_eligible_5_17
      t.integer   :frpm_total_undup_count_5_17
      t.float     :frpm_percent_eligible_5_17

      t.timestamps
    end

    add_index :school_free_reduced_meal_data, :school_id
    add_index :school_free_reduced_meal_data, :date
  end
end

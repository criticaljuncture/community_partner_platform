class CreateSchoolQualityIndicatorSubAreas < ActiveRecord::Migration[4.2]
  def change
    create_table :school_quality_indicator_sub_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end

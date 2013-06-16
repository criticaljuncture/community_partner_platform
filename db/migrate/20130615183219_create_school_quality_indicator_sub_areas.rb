class CreateSchoolQualityIndicatorSubAreas < ActiveRecord::Migration
  def change
    create_table :school_quality_indicator_sub_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end

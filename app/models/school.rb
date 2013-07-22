class School < ActiveRecord::Base
  has_many :community_partners
  has_many :organizations, through: :community_partners

  has_many :school_quality_indicator_sub_areas, through: :community_partners

  has_many :free_reduced_meal_data, class_name: FreeReducedMealData

  belongs_to :region

  def sub_area_counts
    sub_area_counts = []
    SchoolQualityIndicatorSubArea.all.each do |sub_area|
      count = self.school_quality_indicator_sub_areas.where(id: sub_area.id).count
      sub_area_counts << {sub_area_id: sub_area.id, count: count}
    end
    sub_area_counts
  end
end

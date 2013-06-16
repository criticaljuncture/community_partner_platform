class Organization < ActiveRecord::Base
  has_many :community_partners
  has_many :schools, through: :community_partners
  has_many :school_quality_indicator_sub_areas, through: :community_partners

  def self.top_5_for_indicator(indicator_id)
    sql =  "SELECT organizations.name, count(community_partners.id) as community_partnerships_count from organizations
            JOIN community_partners
              ON organizations.id = community_partners.organization_id
            JOIN school_quality_indicator_sub_areas
              ON school_quality_indicator_sub_areas.id = community_partners.school_quality_indicator_sub_area_id
            WHERE school_quality_indicator_sub_areas.id = #{indicator_id}
            GROUP by organizations.id
            ORDER by community_partnerships_count DESC
            LIMIT 5"

    ActiveRecord::Base.connection.execute(sql)
  end
end

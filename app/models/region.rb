class Region < ActiveRecord::Base
  has_many :schools
  has_many :community_partners, through: :schools

  def cached_community_partner_count
    Rails.cache.fetch([self, "cached_community_partner_count"]) do
      schools.map{|s| s.cached_community_partner_count}.sum
    end
  end

  def cached_community_partners
    Rails.cache.fetch([self, "cached_community_partners"]) do
      community_partners
    end
  end

  def community_partners_by_quality_element
    Rails.cache.fetch([self, "community_partners_by_quality_element"]) do
      cached_community_partners.map{|cp| cp.quality_elements}.flatten.group_by(&:id)
    end
  end
end

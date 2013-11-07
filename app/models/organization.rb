class Organization < ActiveRecord::Base
  include OrganizationAudit

  has_many :community_partners
  has_many :schools, through: :community_partners
  has_many :users

  scope :with_users, -> { joins(:users).where("users.organization_id IS NOT NULL").group("organizations.id") }

  def quality_elements
    community_partners.map{|cp| cp.quality_elements}.flatten.uniq
  end

  def service_types
    community_partners.map{|cp| cp.service_types}.flatten.uniq
  end
end

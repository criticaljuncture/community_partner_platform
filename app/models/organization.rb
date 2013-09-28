class Organization < ActiveRecord::Base
  has_many :community_partners
  has_many :schools, through: :community_partners
  has_many :quality_elements, through: :community_partners
  has_many :service_types, through: :community_partners
  has_many :users

  scope :with_users, -> { joins(:users).where("users.organization_id IS NOT NULL").group("organizations.id") }
end

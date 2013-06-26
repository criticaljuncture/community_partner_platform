class School < ActiveRecord::Base
  has_many :community_partners
  has_many :organizations, through: :community_partners

  belongs_to :region
end

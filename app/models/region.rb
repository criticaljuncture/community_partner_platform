class Region < ActiveRecord::Base
  has_many :schools
  has_many :community_partners, through: :schools
end

class CommunityPartnerSerializer < ActiveModel::Serializer
  attributes :id
  has_one :school
  has_one :organization
end

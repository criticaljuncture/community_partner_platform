class CommunityProgramDemographicGroup < ApplicationRecord
  belongs_to :attributable, polymorphic: true
  belongs_to :demographic_group

  delegate :name, to: :demographic_group
end

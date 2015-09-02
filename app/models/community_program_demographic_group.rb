class CommunityProgramDemographicGroup < ActiveRecord::Base
  belongs_to :attributable, polymorphic: true
  belongs_to :demographic_group

  delegate :name, to: :demographic_group
end

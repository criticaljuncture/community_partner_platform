class CommunityProgramEthnicityCultureGroup < ApplicationRecord
  belongs_to :attributable, polymorphic: true
  belongs_to :ethnicity_culture_group

  delegate :name, to: :ethnicity_culture_group
end

class CommunityProgramServiceDay < ApplicationRecord
  belongs_to :attributable, polymorphic: true
  belongs_to :day

  delegate :name, to: :day
end

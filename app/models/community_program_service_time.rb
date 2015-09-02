class CommunityProgramServiceTime < ActiveRecord::Base
  belongs_to :attributable, polymorphic: true
  belongs_to :service_time

  delegate :name, to: :service_time
end

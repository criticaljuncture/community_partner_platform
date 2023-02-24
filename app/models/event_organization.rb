class EventOrganization < ApplicationRecord
  belongs_to :event
  belongs_to :organization
end

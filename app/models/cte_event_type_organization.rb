class CteEventTypeOrganization < ApplicationRecord
  belongs_to :cte_event_type
  belongs_to :organization
end

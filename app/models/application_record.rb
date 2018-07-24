class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Opt into old belongs_to behavour
  self.belongs_to_required_by_default = false
end

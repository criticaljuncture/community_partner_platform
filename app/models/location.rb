class Location < ApplicationRecord
  default_scope -> { where(active: true) }
end

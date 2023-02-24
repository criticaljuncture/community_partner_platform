class Location < ApplicationRecord
  default_scope -> { where(active: true) }

  def default_display
    self.name
  end
end

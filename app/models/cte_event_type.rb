class CteEventType < ApplicationRecord
  def default_display
    self.name
  end
end

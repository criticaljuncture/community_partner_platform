class LegalStatus < ApplicationRecord
  has_many :organizations

  def self.for_select
    all.sort_by(&:name)
  end
end

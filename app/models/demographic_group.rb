class DemographicGroup < ActiveRecord::Base
  def self.for_completeness
    where("id NOT IN(1,2,3)")
  end
end

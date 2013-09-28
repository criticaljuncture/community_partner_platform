class QualityElementServiceType < ActiveRecord::Base
  belongs_to :quality_element
  belongs_to :service_type
end

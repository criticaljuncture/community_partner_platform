FactoryBot.define do
  factory :quality_element do
    sequence(:name) {|i| "Quality Element #{i}"}
    element_type 'programmatic'

    after(:create) do |quality_element|
      create(:service_type, quality_elements: [quality_element])
    end
  end
end

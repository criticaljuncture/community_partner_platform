FactoryBot.define do
  factory :quality_element do
    sequence(:name) {|i| "Quality Element #{i}"}
    element_type 'programmatic'
  end
end

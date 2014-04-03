FactoryGirl.define do
  factory :quality_element do
    sequence(:name) {|i| "Quality Element #{i}"}
  end
end


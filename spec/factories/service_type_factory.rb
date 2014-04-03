FactoryGirl.define do
  factory :service_type do
    sequence(:name) {|i| "Service Type #{i}"}
  end
end

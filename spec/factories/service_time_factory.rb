FactoryBot.define do
  factory :service_time do
    sequence(:name) {|i| "Service Time #{i}"}
  end
end

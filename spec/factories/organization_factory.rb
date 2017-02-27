FactoryGirl.define do
  factory :organization do
    sequence(:name) {|i| "Organization #{i}"}
    legal_status_id 1
  end
end

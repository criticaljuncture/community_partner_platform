FactoryGirl.define do
  factory :organization do
    sequence(:name) {|i| "Organization #{i}"}
  end
end

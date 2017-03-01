FactoryGirl.define do
  factory :community_program do
    sequence(:name) {|i| "Community Program #{i}"}

    association :organization
    association :quality_element
    association :user
  end
end

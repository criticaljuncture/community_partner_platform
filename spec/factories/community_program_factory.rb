FactoryGirl.define do
  factory :community_program do
    sequence(:name) {|i| "Community Program #{i}"}

    association :organization, strategy: :build
    association :quality_element, strategy: :build
    association :user, strategy: :build
  end
end

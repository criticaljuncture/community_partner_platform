FactoryBot.define do
  factory :community_program do
    sequence(:name) {|i| "Community Program #{i}"}
    active true

    association :organization, strategy: :create
    association :quality_element, strategy: :create
    association :user, strategy: :create

    after(:build) do |community_program, evaluator|
      community_program.primary_quality_element.service_types = community_program.quality_element.service_types
    end

    trait(:private) do
      approved_for_public false
      approved_for_public_on nil
      approved_for_public_by nil
    end

    trait(:public) do
      approved_for_public true
      approved_for_public_on { DateTime.current }
      approved_for_public_by 1
    end
  end
end

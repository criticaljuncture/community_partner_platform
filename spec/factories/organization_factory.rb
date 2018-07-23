FactoryBot.define do
  factory :organization do
    sequence(:name) {|i| "Organization #{i}"}
    legal_status_id 1

    trait :approved_for_public do
      approved_for_public true
      approved_for_public_by 1
      approved_for_public_on '2017-01-01'
    end

    factory :public_organization, traits: [:approved_for_public]
  end
end

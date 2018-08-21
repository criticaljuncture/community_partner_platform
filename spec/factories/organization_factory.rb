FactoryBot.define do
  factory :organization do
    sequence(:name) {|i| "Organization #{i}"}
    legal_status { create(:legal_status) }

    trait :private do
      approved_for_public false
      approved_for_public_by nil
      approved_for_public_on nil
    end

    trait :public do
      approved_for_public true
      approved_for_public_by 1
      approved_for_public_on { DateTime.current }
    end
  end
end

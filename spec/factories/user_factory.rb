FactoryBot.define do
  factory :user do
    first_name {|i| "John#{i}"}
    last_name 'Doe'
    email { "#{first_name}.#{last_name}@example.com".downcase }

    password 'Sup3rs3cr3t!'
    password_confirmation 'Sup3rs3cr3t!'

    roles { [build(:role)] }

    trait :district_manager do
      roles { [build(:district_manager_role)] }
    end

    trait :school_manager do
      roles { [build(:school_manager_role)] }

      after(:build) do |user|
        user.schools << build(:school)
      end
    end

    trait :organization_member do
      roles { [build(:organization_member_role)] }
      organization
    end

    trait :multi_role do
      roles { [build(:school_manager_role), build(:organization_member_role)] }
      organization
    end


    factory :district_manager_user, traits: [:district_manager]
    factory :school_manager_user, traits: [:school_manager]
    factory :organization_user, traits: [:organization_member]

    factory :multi_role_user, traits: [:multi_role]
  end
end

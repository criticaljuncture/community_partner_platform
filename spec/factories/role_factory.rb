FactoryGirl.define do
  factory :role do
    sequence(:name) {|i| "Role #{i}"}
    sequence(:identifier) {|i| "role_#{i}".to_sym}

    trait :district_manager do
      name 'District Manager'
      identifier :district_manager
    end

    trait :school_manager do
      name 'School Manager'
      identifier :school_manager
    end

    trait :organization_member do
      name 'Organization Member'
      identifier :organization_member
    end

    factory :district_manager_role, traits: [:district_manager]
    factory :school_manager_role, traits: [:school_manager]
    factory :organization_member_role, traits: [:organization_member]
  end
end

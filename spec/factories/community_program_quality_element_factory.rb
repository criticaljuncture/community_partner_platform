FactoryBot.define do
  factory :community_program_quality_element do
    type 'PrimaryQualityElement'

    association :quality_element
    association :community_program
  end
end

FactoryBot.define do
  factory :school_program do
    association :community_program, strategy: :build
    association :school, strategy: :build
  end
end

FactoryGirl.define do
  factory :community_program do
    sequence(:name) {|i| "Community Program #{i}"}
  end
end

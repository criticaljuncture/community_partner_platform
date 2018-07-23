FactoryBot.define do
  factory :day do
    sequence(:name) {|i| "Day #{i}"}
  end
end

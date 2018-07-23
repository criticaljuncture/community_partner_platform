FactoryBot.define do
  factory :demographic_group do
    sequence(:name) {|i| "Demographic Group #{i}"}
  end
end

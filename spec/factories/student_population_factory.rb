FactoryBot.define do
  factory :student_population do
    sequence(:name) {|i| "Student Population #{i}"}
  end
end

FactoryGirl.define do
  factory :grade_level do
    sequence(:name) {|i| "Grade Level #{i}"}
  end
end

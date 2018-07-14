class UserSchool < ApplicationRecord
  belongs_to :school
  belongs_to :user
end

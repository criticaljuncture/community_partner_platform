class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  default_scope -> { order('user_roles.position ASC') }
end

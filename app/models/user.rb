class User < ActiveRecord::Base
  has_many :user_roles
  has_many :roles, through: :user_roles

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :roles, presence: true

  def role?(role)
    roles.map{|r| r.identifier.to_sym}.include?(role)
  end
end

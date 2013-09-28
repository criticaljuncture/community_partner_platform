class User < ActiveRecord::Base
  has_many :user_roles
  has_many :roles, through: :user_roles

  belongs_to :organization

  has_many :user_schools
  has_many :schools, through: :user_schools

  attr_accessor :primary_role, :admin_creation

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :roles, presence: true
  validates :primary_role, presence: true

  validates :organization_id, presence: true, 
            if: -> { role?(:organization_member) }

  validates :schools, presence: true, 
            if: -> { role?(:school_manager) }

  after_validation :remove_improper_associations_based_on_role
  scope :active,  -> { where(active: true) }

  scope :inactive, -> { where(active: false) }

  def role?(role)
    roles.map{|r| r.identifier.to_sym}.include?(role)
  end
  def primary_role
    @primary_role || roles.try(:first)
  end

  def primary_role=(role)
    @primary_role = role
  end

  def activate_user
    self.active = true
    self.save(validate: false)
  end

  protected 

  def password_required?
    !admin_creation
  end

end

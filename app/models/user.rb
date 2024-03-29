class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  include UserAudit

  after_create :clear_associated_cache
  before_update :watch_associations
  after_update :clear_associated_cache

  has_many :user_roles
  has_many :roles, through: :user_roles

  belongs_to :organization
  belongs_to :orientation_type

  has_many :user_schools
  has_many :schools, through: :user_schools

  has_many :community_programs_as_organization_contact,
           class_name: 'CommunityProgram',
           foreign_key: :user_id

  has_many :school_programs_as_school_contact,
           class_name: 'SchoolProgram',
           foreign_key: :user_id

  has_many :page_views

  attr_accessor :primary_role, :admin_creation, :school_ids_were, :new_org_creation

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable

  validates :password,
    format: {
      with: /\d/,
      message: "must contain at least one number",
      allow_blank: true
    }
  validates :password,
    format: {
      with: /[a-z]/,
      message: "must contain at least one lowercase letter",
      allow_blank: true
    }
  validates :password,
    format: {
      with: /[A-Z]/,
      message: "must contain at least one uppercase letter",
      allow_blank: true
    }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  validates :roles, presence: true
  validates :primary_role, presence: true

  validates :organization_id, presence: true,
            if: -> { role?(:organization_member) && new_org_creation.blank?}

  validates :schools, presence: true,
            if: -> { role?(:school_manager) }

  validates :orientation_type_id, presence: true,
            if: Proc.new { |u| u.attended_orientation_at }

  after_validation :remove_improper_associations_based_on_role

  after_invitation_accepted :activate_user

  scope :active,  -> { where(active: true) }

  scope :inactive, -> { where(active: false) }

  scope :as_contact, -> { where('invitation_sent_at IS NULL') }
  scope :as_invited_contact, -> { where('invitation_sent_at IS NOT NULL') }

  def self.current=(user)
    RequestStore.store[:current_user] = user
  end

  def self.current
    RequestStore.store[:current_user]
  end

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability


  def role?(role)
    roles.map{|r| r.identifier.to_sym}.include?(role)
  end

  def full_name
    "#{first_name} #{last_name}"
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

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    I18n.t('users.flash_messages.inactive')
  end

  protected

  def password_required?
    admin_creation ? false : super
  end

  private

  def remove_improper_associations_based_on_role
    return unless self.roles.present?

    # only remove other attributes if the user has one role
    # otherwise we leave things alone...
    if self.roles.count == 1
      role = self.roles.first.identifier

      case role
      when :super_admin, :district_manager
        self.schools = []
        self.organization = nil
      when :school_manager
        self.organization = nil
      when :organization_member
        self.schools = []
      end

      self.save(validate: false)
    end
  end

  def watch_associations
    self.school_ids_were = self.school_ids.sort
  end

  def clear_associated_cache
    schools.each{|s| s.touch} if self.school_ids.sort != self.school_ids_were
    organization.touch if organization.present? && organization.changed?
  end
end

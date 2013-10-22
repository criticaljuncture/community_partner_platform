class AddRoleForm
  include ActiveModel::Model

  attr_reader :user
  attr_accessor :role, :organization, :schools, :position

  validates :role, presence: true

  validates :organization, presence: true, 
            if: -> { role?(:organization_member) }

  validates :schools, presence: true,
            if: -> { role?(:school_manager) }

  validates :position, presence: true

  validate :role_is_not_already_assigned

  def initialize(user)
    @user = user
  end

  def submit(params)
    self.role = Role.find( params[:role] ) 
    self.organization = params[:organization]
    self.schools = params[:schools]

    self.position = user.user_roles.last.position + 1

    save
  end

  def save
    if valid?
      user_role = UserRole.new(user: user, role: self.role, position: self.position)

      user.organization_id = self.organization if self.organization
      user.school_ids = self.schools if self.schools

      User.transaction do
        user.save
        user_role.save
      end
    else
      false
    end
  end

  def role?(role)
    self.role.identifier.to_sym == role
  end

  def role_is_not_already_assigned
    ! user.role?(role)
  end

  def available_roles(current_ability)
    @available_roles ||= Role.accessible_by(current_ability) - @user.roles
  end

  def available_role_identifiers(current_ability)
    @available_role_identifiers = available_roles(current_ability).map{|r| r.identifier.to_sym}
  end
end

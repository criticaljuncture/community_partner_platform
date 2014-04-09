class Ability < BaseAbility
  def debug_abilities
    can :view, :debug_toolbar
  end

  def super_admin_abilities
    debug_abilities

    can :manage, :all

    can :send_invitation, User
    can :view, :admin_dashboard
  end

  def district_manager_abilities
    can :manage, User
    can :add_role, User
    can :send_invitation, User

    can :read, Role, id: [2,3,4]
    can :manage, School
    can :manage, CommunityProgram

    can :manage, Organization
    can :manage_district_details, Organization

    can :manage, QualityElement
    can :manage, ServiceType
    can :read, :organization_users
    can :read, Region
  end

  def school_manager_abilities
  end

  def organization_member_abilities
    can [:edit, :update, :verification], Organization, id: @user.organization_id
    can :read, :organization_users

    can :new, User
    can [:index, :show, :create, :update], User, organization_id: @user.organization_id
    can :create, User, role_id: 3 #school_user
    can :send_invitation, User, organization_id: @user.organization_id

    can :read, :primary_school_contact_input

    can :read, QualityElement

    can :read, Role, id: [3,4]

    can :new, CommunityProgram
    can [:create, :edit, :update], CommunityProgram, organization_id: @user.organization_id

    can [:index, :new], User
    can [:create, :update], User, organization_id: @user.organization_id
    can :create, User, primary_role: {id: [3,4]}
  end

  def shared_abilities
    can :manage, :application do
      can?(:manage, QualityElement) || can?(:manage, ServiceType) || can?(:index, User)
    end
  end

  def public_abilities
    can :read, School
    can :read, CommunityProgram
    can :read, Organization

    can :read, QualityElement
    can :read, ServiceType
    can :read, Day
    can :read, ServiceTime
    can :read, StudentPopulation
    can :read, GradeLevel
    can :read, DemographicGroup
    can :read, EthnicityCultureGroup
  end
end

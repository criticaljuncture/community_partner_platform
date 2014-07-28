class Ability < BaseAbility
  def debug_abilities
    can :view, :debug_toolbar
  end

  def super_admin_abilities
    debug_abilities

    can :manage, :all

    can :send_invitation, User
    can :view, :admin_dashboard

    admin_page_level_abilities
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

    can :verify, CommunityProgram

    admin_page_level_abilities
  end

  def school_manager_abilities
    can :verify, CommunityProgram, school_id: @user.school_id
  end

  def organization_member_abilities
    can [:edit, :update, :verification, :verify], Organization, id: @user.organization_id
    can :read, :organization_users

    can :new, User
    can [:index, :show, :create, :update], User, organization_id: @user.organization_id
    can :create, User, role_id: 3 #school_user
    can :send_invitation, User, organization_id: @user.organization_id

    can [:index, :new], User
    can :create, User, primary_role: {id: [3,4]}

    can :read, :primary_school_contact_input

    can :read, QualityElement

    can :read, Role, id: [3,4]

    can :new, CommunityProgram
    can [:create, :edit, :update], CommunityProgram, organization_id: @user.organization_id
    can :verify, CommunityProgram, organization_id: @user.organization_id

    organization_member_page_level_abilities
  end

  def shared_abilities
    can :manage, :application do
      can?(:manage, QualityElement) || can?(:manage, ServiceType) || can?(:index, User) || can?(:view, :admin_dashboard)
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

  def admin_page_level_abilities
    can :view, :school_overview_scatter_plot
    can :view, :school_overview_program_breakdown_by_region
    can :view, :school_overview_community_school_element_breakdown
    can :view, :school_overview_school_status

    can :view, :school_partnership_status_dashboard_panels

    can :view, :visualizations

    organization_member_page_level_abilities
  end

  def organization_member_page_level_abilities
    can :view, :user_details
  end
end

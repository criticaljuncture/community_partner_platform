class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.role?(:super_admin)
      can :manage, :all
    elsif user.role?(:district_manager)
      can :manage, User
      can :read, Role, id: [2,3,4]
      can :manage, School
      can :manage, CommunityPartner
      can :manage, Organization
      can :manage, QualityElement
      can :manage, ServiceType
      can :read, :organization_users
      can :read, Day
      can :read, ServiceTime
      can :read, StudentPopulation
      can :read, GradeLevel
      can :read, DemographicGroup
    else
      can :read, School
      can :read, CommunityPartner
      can :read, Organization
    end
    
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

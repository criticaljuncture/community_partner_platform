class BaseAbility
  include CanCan::Ability
  prepend Draper::CanCanCan
  
  attr_reader :user

  def initialize(user)
    @user = user || User.new # guest user (not logged in)

    if @user
      public_abilities

      @user.roles.each do |role|
        send(role.identifier + "_abilities")
      end

      shared_abilities

      if Rails.env.development?
        debug_abilities
      end
    end
  end
end

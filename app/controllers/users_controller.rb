class UsersController < ApplicationController
  authorize_resource :user
  skip_before_filter :require_no_authentication

  def index
    @active_users = User.accessible_by(current_ability).active.sort_by(&:last_name).sort_by(&:first_name)
    @inactive_users = User.accessible_by(current_ability).inactive.sort_by(&:last_name).sort_by(&:first_name)
  end

  def show
    @user = User.accessible_by(current_ability).find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    begin
      User.transaction do
        primary_role = user_params[:primary_role].present? ? user_params[:primary_role].to_i : nil
        if primary_role
          @user.roles = [ Role.accessible_by(current_ability).find( primary_role ) ]
          @user.primary_role = @user.roles.first
        end

        @user.admin_creation = can?(:create, User)
        @user.save!
     
        flash.notice = "#{@user.full_name} has been created with role '#{@user.primary_role.name}', but not invited to the Community Partner Platform." 
        redirect_to users_path(active_tab: 'inactive')
      end
    rescue ActiveRecord::RecordInvalid
      render action: :new
    end
  end

  def edit
    @user = User.accessible_by(current_ability).find(params[:id])
  end

  def update
    @user = User.accessible_by(current_ability).find(params[:id])

    primary_role = user_params[:primary_role].present? ? user_params[:primary_role].to_i : nil
    
    begin
      User.transaction do
        if primary_role
          @user.roles = [ Role.accessible_by(current_ability).find( primary_role ) ]
          @user.primary_role = Role.accessible_by(current_ability).find( primary_role )
        end

        @user.admin_creation = can?(:update, User)

        @user.update_attributes!(user_params.except(:primary_role))

        redirect_to action: :index
      end
    rescue ActiveRecord::RecordInvalid
      render action: :edit
    end
  end

  def send_invitation
    @user = User.accessible_by(current_ability).find(params[:id])
    @user.invite!(current_user)

    flash.notice = "Sent invitation to #{@user.full_name} (#{@user.email})."
    redirect_to users_path(active_tab: 'inactive')
  end

  private

  def user_params
    params.require(:user).permit(:first_name, 
                                 :last_name,
                                 :email,
                                 :phone_number,
                                 :primary_role,
                                 :organization_id,
                                 school_ids: [])
  end
end

class UsersController < ApplicationController
  skip_before_filter :require_no_authentication

  def index
    @active_users = User.accessible_by(current_ability, :update).active.sort_by(&:last_name).sort_by(&:first_name)
    @inactive_users = User.accessible_by(current_ability, :update).inactive.sort_by(&:last_name).sort_by(&:first_name)
    authorize! :index, User
  end

  def show
    @user = User.find(params[:id])
    authorize! :show, @user
  end

  def new
    @user = User.new
    authorize! :create, @user
  end

  def create
    @user = User.new(user_params)
    authorize! :create, @user

    begin
      User.transaction do
        primary_role = user_params[:primary_role].present? ? user_params[:primary_role].to_i : nil
        if primary_role
          @user.roles = [ Role.accessible_by(current_ability).find( primary_role ) ]
          @user.primary_role = @user.roles.first
        end

        @user.admin_creation = can?(:create, User)
        @user.save!

        flash.notice = t('users.flash_messages.create.success',
                         name: @user.full_name,
                         role: @user.primary_role.name)
        redirect_to users_path(active_tab: 'inactive')
      end
    rescue ActiveRecord::RecordInvalid
      flash.now[:notice] = t('users.flash_messages.save.failure',
                            errors: @user.errors.count)
      render action: :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user

    primary_role = user_params[:primary_role].present? ? user_params[:primary_role].to_i : nil

    begin
      User.transaction do
        if primary_role
          @user.roles = [ Role.accessible_by(current_ability).find( primary_role ) ]
          @user.primary_role = Role.accessible_by(current_ability).find( primary_role )
        end

        @user.admin_creation = can?(:update, User)

        @user.update_attributes!(user_params.except(:primary_role))

        flash.notice = t('users.flash_messages.update.success',
                         name: @user.full_name)

        redirect_to action: :index
      end
    rescue ActiveRecord::RecordInvalid
      flash.now[:notice] = t('users.flash_messages.save.failure',
                            errors: @user.errors.count)

      render action: :edit
    end
  end

  def send_invitation
    @user = User.find(params[:id])
    authorize! :send_invitation, @user

    @user.invite!(current_user)

    flash.notice = t('users.flash_messages.invitation.sent',
                     name: @user.full_name,
                     email: @user.email)
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

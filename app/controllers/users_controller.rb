class UsersController < ApplicationController
  def index
    authorize! :index, User

    @active_users = UserDecorator.decorate_collection(
      User.accessible_by(current_ability, :update).
        includes(:roles, :organization, :schools).
        active.sort_by(&:last_name).sort_by(&:first_name)
    )

    @inactive_users = UserDecorator.decorate_collection(
      User.accessible_by(current_ability, :update).
        includes(:roles, :organization, :schools).
        inactive.sort_by(&:last_name).sort_by(&:first_name)
    )
  end

  def show
    @user = User.where(id: params[:id]).
      includes(
        :school_programs_as_school_contact,
        :community_programs_as_organization_contact
      ).
      first.decorate
    authorize! :show, @user

    @school_programs_by_community_program = @user.
      school_programs_as_school_contact.
      group_by(&:community_program).
      sort_by{|community_program, school_program| community_program.name}.
      to_h
  end

  def new
    if params[:user]
      @user = User.new(user_params)
    else
      @user = User.new
    end

    authorize! :new, @user

    if request.xhr?
      if user_params[:organization_id].present?
        @organizations = Array(Organization.find(user_params[:organization_id]))
      else
        @organizations = []
      end

      @schools = if params[:school_id]
          Array(
            School.accessible_by(current_ability).
            where(id: params[:school_id])
          )
        else
          []
        end

      role = Role.accessible_by(current_ability).
        where(id: params[:role_id])
      @roles = role.map{|r| [r.name, r.id, {"data-role-type" => r.identifier}]}
      @user.primary_role = role.first
      render :ajax_new, layout: false
    else
      @organizations = Organization.accessible_by(current_ability, :update).select('name, id').sort_by(&:name)
      @schools = School.accessible_by(current_ability).select('name, id').sort_by(&:name)
      @roles = Role.accessible_by(current_ability).map{|r| [r.name, r.id, {"data-role-type" => r.identifier}]}
      render :new
    end
  end

  def create
    params[:user][:school_ids] = Array( params[:user][:school_ids] )
    @user = User.new(user_params)

    begin
      User.transaction do
        primary_role_id = user_params[:primary_role].present? ? user_params[:primary_role].to_i : nil
        if primary_role_id
          @user.roles = [ Role.accessible_by(current_ability).find( primary_role_id ) ]
          @user.primary_role = @user.roles.first
        end

        set_orientation_fields

        authorize! :create, @user

        @user.subdomain = current_user.subdomain
        @user.admin_creation = can?(:create, User)
        @user.save!

        message = t('users.flash_messages.create.success',
                             name: @user.full_name,
                             role: @user.primary_role.name)

        respond_to do |format|
          format.html {
            flash.notice = message
            redirect_to user_path(@user)
          }

          format.json {
            render json: {message: message, user: {name: @user.full_name, id: @user.id, role_id: @user.primary_role.id}}, status: 200
          }
        end
      end
    rescue ActiveRecord::RecordInvalid
      message = t('users.flash_messages.save.failure',
                  count: @user.errors.count )

      respond_to do |format|
        format.html {
          @organizations = Organization.accessible_by(current_ability, :update).select('name, id').sort_by(&:name)
          @schools = School.accessible_by(current_ability).select('name, id').sort_by(&:name)
          @roles = Role.accessible_by(current_ability).map{|r| [r.name, r.id, {"data-role-type" => r.identifier}]}

          flash.now[:notice] = message
          render action: :new
        }

        format.json {
          render json: {message: message, errors: @user.errors}, status: 400
        }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @organizations = Organization.accessible_by(current_ability, :update).select('name, id').sort_by(&:name)
    @schools = School.accessible_by(current_ability).select('name, id').sort_by(&:name)
    @roles = Role.accessible_by(current_ability).map{|r| [r.name, r.id, {"data-role-type" => r.identifier}]}

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

        @user.attributes = user_params.except(:primary_role, :new_org_creation)
        set_orientation_fields

        @user.save!

        flash.notice = t('users.flash_messages.update.success',
                         name: @user.full_name)

        redirect_to user_path(@user)
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
    redirect_to users_path(anchor: 'inactive')
  end

  private

  def set_orientation_fields
    if @user.orientation_type_id_changed? &&
       @user.orientation_type_id.present? &&
       @user.attended_orientation_at.blank?

      @user.attended_orientation_at = Date.current
    end
  end

  def user_params
    params.require(:user).permit(
      :active,
      :attended_orientation_at,
      :email,
      :first_name,
      :last_name,
      :new_org_creation,
      :organization_id,
      :orientation_type_id,
      :phone_number,
      :primary_role,
      :title,
      school_ids: []
    ).tap do |u_params|
      u_params.delete(:active) unless can? :manage, User
    end
  end
end

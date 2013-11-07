class UserRolesController < ApplicationController
  authorize_resource :user

  def new
    @user = User.accessible_by(current_ability).find(params[:user_id])
    @user_role = AddRoleForm.new(@user)
  end

  def create
    @user = User.accessible_by(current_ability).find(params[:user_id])
    @user_role = AddRoleForm.new(@user)

    if @user_role.submit(user_role_params)
      redirect_to user_path(@user), notice: "Role '#{@user_role.role.name}' successfully added to #{@user.full_name}."
    else
      render action: :new
    end
  end

  def destroy
    @user = User.accessible_by(current_ability).find(params[:user_id])
    @user_role = @user.user_roles.find(params[:id])

    User.transaction do
      case @user_role.role.identifier.to_sym
      when :school_manager
        @schools_to_update = @user.schools.all
        @user.user_schools.each{|user_school| user_school.destroy}
        @schools_to_update.each{|s| s.update_version}
      when :organization_member
        @user.organization = nil
      end

      @user_role.destroy
      @user.save
    end

    redirect_to user_path(@user), notice: "Role '#{@user_role.role.name}' successfully removed from #{@user.full_name}."
  end

  private

  def user_role_params
    params.
      require(:add_role_form).
      permit(
        :role,
        :organization,
        schools: [],
      )
  end
end

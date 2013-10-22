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

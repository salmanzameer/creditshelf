class Devise::RegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        @user.add_role :employee
        @user.manage_mystery_group
        format.html { redirect_to user_url(@user), notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :department_id)
  end
end

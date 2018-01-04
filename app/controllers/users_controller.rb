class UsersController < ApplicationController
  def edit_username
    @user = current_user
  end

  def update
    current_user.update(user_params)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end

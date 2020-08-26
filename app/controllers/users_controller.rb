class UsersController < ApplicationController
  def edit
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end
end

private

def user_params
  params.require(:user).permit(:first_name, :last_name, :description, :photo)
end

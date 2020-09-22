class UsersController < ApplicationController

  def index
    @users = policy_scope(User).order(:last_name)

    if params[:query].present?
      @users = User.search_by_name(params[:query])
    else
      @users
    end

  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to @user
    authorize @user
  end
end

private

def user_params
  params.require(:user).permit(:first_name, :last_name, :description, :photo, portfolio_photos: [])
end

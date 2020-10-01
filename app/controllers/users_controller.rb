class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.with(user: @user).welcome_email.deliver_now

        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

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

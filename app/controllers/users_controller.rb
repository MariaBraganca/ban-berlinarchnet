class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  skip_before_action :authenticate_user!, only: :index

  def index
    @users = policy_scope(User).includes(photo_attachment: :blob).order(:last_name)

    if params[:query].present?
      @users = User.search_by_name(params[:query])
    else
      @users
    end
  end

  def show
    @user_experiences = @user.experiences.includes(:office)
    @user_events = @user.events.includes(cover_photo_attachment: :blob)
    @user_posts = @user.posts.includes(:tags)
    authorize @user
  end

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

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'devise/registrations/edit'
    end
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :photo, portfolio_photos: [])
  end
end

class ExperiencesController < ApplicationController
  before_action :set_user, only: [:new, :create]

  def index
    @experiences = policy_scope(Experience).order(start_date: :desc)
  end

  def new
    @experience = Experience.new
    authorize @experience
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user = @user

    if @experience.save
      redirect_to user_path(@user)
    else
      render :new
    end

    authorize @experience
  end

  private

  def experience_params
    params.require(:experience).permit(:start_date, :end_date, :job_position, :office_id, :user_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end

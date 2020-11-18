class OpeningsController < ApplicationController
	skip_before_action :authenticate_user!, only: [ :index, :show]
  before_action :set_opening, only: [:show, :edit, :update, :destroy]

  def index
  	@openings = policy_scope(Opening).order(date: :desc)
  end

  def show
  	authorize @opening
  end

  def new
    @opening = Opening.new
    authorize @opening
  end

  def create
    @opening = Opening.new(opening_params)
    @opening.date = Time.now()
    @opening.job_site = "·ban"

    if @opening.save
      redirect_to opening_path(@opening)
    else
      render :new
    end
    authorize @opening
  end

  def edit
    authorize @opening
  end

  def update
    if @opening.update(opening_params)
      redirect_to opening_path(@opening)
    else
      render :edit
    end
    authorize @opening
  end

  def destroy
    @opening.destroy
    authorize @opening

    redirect_to openings_path
  end


  private

  def set_opening
    @opening = Opening.find(params[:id])
  end

  def opening_params
    params.require(:opening).permit(:date, :job_position, :description, :office_id, :job_site)
  end

end

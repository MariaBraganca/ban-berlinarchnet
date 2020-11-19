class OfficeProjectsController < ApplicationController
  before_action :set_office, only: [:new, :create]

  def index
    @office_projects = policy_scope(OfficeProject).order(:project_name)
  end

  def new
    @office_project = OfficeProject.new
    authorize @office_project
  end

  def create
    @office_project = OfficeProject.new(office_project_params)
    @office_project.office = @office
    if @office_project.save
      redirect_to office_path(@office)
    else
      render :new
    end
    authorize @office_project
  end

  private

  def office_project_params
    params.require(:office_project).permit(:project_name, :project_img_url, :photo, :office_id)
  end

  def set_office
    @office = Office.find(params[:office_id])
  end
end

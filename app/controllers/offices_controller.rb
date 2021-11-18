class OfficesController < ApplicationController
  OFFICES_PER_PAGE = 10

  before_action :set_office, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @page = params.fetch(:page, 0).to_i

    @offices = policy_scope(Office)
      .includes(:ratings, photo_attachment: :blob)
      .order(:name)
      .limit(OFFICES_PER_PAGE)
      .offset(@page * OFFICES_PER_PAGE)

    search_and_sort()

    @markers = @offices.geocoded.map do |office|
      {
        lat: office.latitude,
        lng: office.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { office: office })
      }
    end
  end

  def show
    @office_users = @office.users.includes(photo_attachment: :blob)
    @office_projects = @office.office_projects.includes(photo_attachment: :blob)
    @office_comments = @office.comments.includes(user: :photo_attachment).order(date: :desc)
    authorize @office

    @marker = [
      {
        lat: @office.latitude,
        lng: @office.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { office: @office })
      }]

    @comment = Comment.new
  end

  def new
    @office = Office.new
    authorize @office
  end

  def create
    @office = Office.new(office_params)

    if @office.save
      redirect_to office_path(@office)
    else
      render :new
    end
    authorize @office
  end

  def edit
    authorize @office
  end

  def update
    if @office.update(office_params)
      redirect_to office_path(@office)
    else
      render :edit
    end
    authorize @office
  end

  private

  def set_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.require(:office).permit(:name, :location, :url, :description, :photo)
  end

  def search_and_sort
    if params[:query].present? && params[:order].present?
      if params[:order] == "@offices_arch"
        offices_ordered = policy_scope(Office).joins(:ratings).group('offices.id').order('avg(ratings.architecture) desc').limit(OFFICES_PER_PAGE).offset(@page * OFFICES_PER_PAGE)
      elsif params[:order] == "@offices_cult"
        offices_ordered = policy_scope(Office).joins(:ratings).group('offices.id').order('avg(ratings.culture) desc').limit(OFFICES_PER_PAGE).offset(@page * OFFICES_PER_PAGE)
      elsif params[:order] == "@offices_sala"
        offices_ordered = policy_scope(Office).joins(:ratings).group('offices.id').order('avg(ratings.salary) desc').limit(OFFICES_PER_PAGE).offset(@page * OFFICES_PER_PAGE)
      end
      offices_search = policy_scope(Office).office_search(params[:query]).limit(OFFICES_PER_PAGE).offset(@page * OFFICES_PER_PAGE)
      @offices = offices_ordered & offices_search

    elsif params[:order].present?
      if params[:order] == "@offices_arch"
        @offices = policy_scope(Office).joins(:ratings).group('offices.id').order('avg(ratings.architecture) desc').limit(OFFICES_PER_PAGE).offset(@page * OFFICES_PER_PAGE)
      elsif params[:order] == "@offices_cult"
        @offices = policy_scope(Office).joins(:ratings).group('offices.id').order('avg(ratings.culture) desc').limit(OFFICES_PER_PAGE).offset(@page * OFFICES_PER_PAGE)
      elsif params[:order] == "@offices_sala"
        @offices = policy_scope(Office).joins(:ratings).group('offices.id').order('avg(ratings.salary) desc').limit(OFFICES_PER_PAGE).offset(@page * OFFICES_PER_PAGE)
      end
    elsif params[:query].present?
      @offices = policy_scope(Office).office_search(params[:query]).limit(OFFICES_PER_PAGE).offset(@page * OFFICES_PER_PAGE)
    end
  end
end

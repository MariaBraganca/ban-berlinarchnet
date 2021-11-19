class OfficesController < ApplicationController
  OFFICES_PER_PAGE = 10

  before_action :set_office, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @page = params.fetch(:page, 0).to_i
    @scope = policy_scope(Office)

    @offices = search_and_sort()

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
    if params[:order].present?
      return Queries::OfficesQueries.new(@scope, @page, OFFICES_PER_PAGE).averages('architecture') if params[:order] == '@offices_arch'
      return Queries::OfficesQueries.new(@scope, @page, OFFICES_PER_PAGE).averages('culture') if params[:order] == '@offices_cult'
      return Queries::OfficesQueries.new(@scope, @page, OFFICES_PER_PAGE).averages('salary') if params[:order] == '@offices_sala'
    elsif params[:query].present?
      Queries::OfficesQueries.new(@scope, @page, OFFICES_PER_PAGE).search(params[:query])
    else
      Queries::OfficesQueries.new(@scope, @page, OFFICES_PER_PAGE).alphabetic
    end
  rescue StandardError => error
    Rails.logger.info("Error: #{error.message}. Couldn't find any records for the search or sort criteria.")
    []
  end
end

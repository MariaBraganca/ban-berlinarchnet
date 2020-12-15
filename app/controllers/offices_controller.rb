class OfficesController < ApplicationController
  before_action :set_office, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @offices = policy_scope(Office.includes(:ratings, photo_attachment: :blob)).order(:name)

    @markers = @offices.geocoded.map do |office|
      {
        lat: office.latitude,
        lng: office.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { office: office })
      }
    end

    search_and_sort()
  end

  def show
    authorize @office

    @marker = [
      {
        lat: @office.latitude,
        lng: @office.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { office: @office })
      }]

    set_average()

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
        offices_ordered = Office.joins(:ratings).group('offices.id').order('avg(ratings.architecture) desc')
      elsif params[:order] == "@offices_cult"
        offices_ordered = Office.joins(:ratings).group('offices.id').order('avg(ratings.culture) desc')
      elsif params[:order] == "@offices_sala"
        offices_ordered = Office.joins(:ratings).group('offices.id').order('avg(ratings.salary) desc')
      end
      offices_search = Office.office_search(params[:query])
      @offices = offices_ordered & offices_search

    elsif params[:order].present?
      if params[:order] == "@offices_arch"
        @offices = Office.joins(:ratings).group('offices.id').order('avg(ratings.architecture) desc')
      elsif params[:order] == "@offices_cult"
        @offices = Office.joins(:ratings).group('offices.id').order('avg(ratings.culture) desc')
      elsif params[:order] == "@offices_sala"
        @offices = Office.joins(:ratings).group('offices.id').order('avg(ratings.salary) desc')
      end
    elsif params[:query].present?
      @offices = Office.office_search(params[:query])
    end
  end

  def set_average
    # Averages
    if @office.ratings.empty?
      @culture_average = 0
      @salary_average = 0
      @architecture_average = 0
    else
      # Average Ratings for Culture
      culture_ratings = []
      @office.ratings.each do |rating|
        culture_ratings << rating.culture
      end
      @culture_average = (culture_ratings.sum / culture_ratings.size).round
      # Average Ratings for Salary
      salary_ratings = []
      @office.ratings.each do |rating|
        salary_ratings << rating.salary
      end
      @salary_average = (salary_ratings.sum / salary_ratings.size).round
      # Average Ratings for Architecture
      architecture_ratings = []
      @office.ratings.each do |rating|
        architecture_ratings << rating.architecture
      end
      @architecture_average = (architecture_ratings.sum / architecture_ratings.size).round
    end
  end
end

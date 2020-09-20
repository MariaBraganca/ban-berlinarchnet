class OfficesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]


  def index

    @offices = policy_scope(Office).order(:name)

    @markers = @offices.geocoded.map do |office|
      {
        lat: office.latitude,
        lng: office.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { office: office })
      }
    end
    
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


  def show
    @office = Office.find(params[:id])
    authorize @office

    @marker = [
      {
        lat: @office.latitude,
        lng: @office.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { office: @office })
      }]

    # Averages
    if @office.ratings.empty?
      @culture_average = 0
      @salary_average = 0
      @architecture_average = 0
    else
      # Average Ratings for Culture
      total = []
      @office.ratings.each do |rating|
        total << rating.culture
      end
      @culture_average = (total.sum / total.size).round
      # Average Ratings for Salary
      total = []
      @office.ratings.each do |rating|
        total << rating.salary
      end
      @salary_average = (total.sum / total.size).round
      # Average Ratings for Architecture
      total = []
      @office.ratings.each do |rating|
        total << rating.architecture
      end
      @architecture_average = (total.sum / total.size).round
    end

    @comment = Comment.new
  end 
end

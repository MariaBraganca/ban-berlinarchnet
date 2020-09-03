class OfficesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]


  def index

    @offices = policy_scope(Office).order(:name)

    if params[:query].present?
      @offices = Office.office_search(params[:query])

    else
    if !params[:order].present?
      @offices = policy_scope(Office).order(:name)
    elsif params[:order] == "@offices_arch"
      @offices = policy_scope(Office).joins(:ratings).group('offices.id').order('avg(ratings.architecture) desc')
    elsif params[:order] == "@offices_cult"
      @offices = policy_scope(Office).joins(:ratings).group('offices.id').order('avg(ratings.culture) desc')
    elsif params[:order] == "@offices_sala"
      @offices = policy_scope(Office).joins(:ratings).group('offices.id').order('avg(ratings.salary) desc')
    end
    end
   
  end


  def show
    @office = Office.find(params[:id])
    authorize @office

    @marker = [
      {
        lat: @office.latitude,
        lng: @office.longitude
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

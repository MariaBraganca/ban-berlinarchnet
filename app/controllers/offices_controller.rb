class OfficesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
  end

  def show
    @office = Office.find(params[:id])
    authorize @office

    @marker = [
      {
        lat: @office.latitude,
        lng: @office.longitude
      }]
  end
end

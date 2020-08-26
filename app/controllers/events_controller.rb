class EventsController < ApplicationController
  before_action :set_event, only: [:show]
  skip_before_action :authenticate_user!, only: [ :index, :show]
  def index
  end

  def show
    authorize @event
    @rsvp = Rsvp.new

    @marker = [
      {
        lat: @event.latitude,
        lng: @event.longitude
      }]
  end

  def new
    @event = Event.new
    @user = current_user
  end

  def edit
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:date_time, :location, :title, :description)
  end

end

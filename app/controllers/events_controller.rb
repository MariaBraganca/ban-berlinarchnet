class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show]
  def index
  end

  def show
    @rsvp = Rsvp.new
    authorize @event

    @marker = [
      {
        lat: @event.latitude,
        lng: @event.longitude
      }]
  end

  def new
    @event = Event.new
    @user = current_user
    authorize @event
  end

  def edit
    @event = Event.find(params[:id])
    @user = User.find(current_user.id)
    authorize @event
end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
    authorize @event
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:date_time, :location, :title, :description)
  end

end

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @events = policy_scope(Event).order(created_at: :desc)
    @user = User.find_by(email: @user)

  end

  def show
    @comment = Comment.new
    @events = Event.all
    @rsvp = Rsvp.new
    authorize @event
    authorize @rsvp
    @rsvp.event_id = @event.id
    

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

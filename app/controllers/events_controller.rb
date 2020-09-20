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
    @user_attending = !@event.users.none?{|user| user == current_user}
    if @user_attending
      @rsvp = @event.rsvps.find{|rsvp|rsvp.user == current_user}
      #retrieve the corresponding rsvp
    end
    authorize @event

    @marker = [
      {
        lat: @event.latitude,
        lng: @event.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { event: @event })
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
    params.require(:event).permit(:date, :start_time, :end_time, :location, :venue, :title, :description, :cover_photo, event_photos: [])
  end

end

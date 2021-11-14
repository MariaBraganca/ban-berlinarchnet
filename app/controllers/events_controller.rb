class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @events = policy_scope(Event).includes(cover_photo_attachment: :blob).order(start_date: :desc)
  end

  def show
    @event_users = @event.users.includes(photo_attachment: :blob)
    @user_attending = @event_users.any? { |user| user == current_user }
    @rsvp = @event.rsvps.find { |rsvp| rsvp.user == current_user } if @user_attending

    authorize @event

    @marker = [
      {
        lat: @event.latitude,
        lng: @event.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { event: @event })
      }]

    @comment = Comment.new
  end

  def new
    @event = Event.new
    authorize @event
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

  def edit
    @user = User.find(current_user.id)
    authorize @event
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
    authorize @event
  end

  def destroy
    @event.destroy
    authorize @event

    redirect_to events_path
  end

  private

  def set_event
    @event = policy_scope(Event).find(params[:id])
  end

  def event_params
    params.require(:event).permit(:start_date, :end_date, :format, :location, :venue, :title, :description, :online, :online_link, :cover_photo, event_photos: [])
  end
end

class RsvpsController < ApplicationController

def new
@event = Event.find(params[:event_id])
@rsvp = Rsvp.new
end


def create
    @event = Event.find(params[:event_id])
    @rsvp = Rsvp.new(rsvp_params)
    @rsvp.user = current_user
    @rsvp.event = @event
    authorize @rsvp
    @rsvp.save!

    if @rsvp.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

private
  def rsvp_params
    params.permit(:user_id, :event_id)
  end
end

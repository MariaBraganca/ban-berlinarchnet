class RsvpsController < ApplicationController
  #before_action :set_rsvp, only: [:destroy]




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

    if @rsvp.save
      redirect_to event_path(@event, anchor: "attending")
    else
      render :new
    end
end

def destroy
  @rsvp = Rsvp.find(params[:id])
  @rsvp.destroy
  authorize @rsvp
  @event = @rsvp.event
  redirect_to event_path(@event)
end

private
  def rsvp_params
    params.permit(:user_id, :event_id, :id)
  end

  def set_rsvp
    @rsvp = Rsvp.find(params[:user_id])
  end

end

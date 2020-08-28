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
    @rsvp.save!

    if @rsvp.save
      redirect_to event_path(@event)
    else
      render :new
    end
end

#def destroy

#@event = Event.find(params[:id])
#@event = @rsvp.event_id
#@rsvp.destroy
#authorize @rsvp
#redirect_to event_path(@rsvp.event)

#end

private
  def rsvp_params
    params.permit(:user_id, :event_id)
  end

  def set_rsvp
    @rsvp = Rsvp.find(params[:id])
  end

end

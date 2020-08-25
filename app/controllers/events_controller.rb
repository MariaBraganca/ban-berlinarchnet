class EventsController < ApplicationController
  before_action :set_event, only: [:show]
  skip_before_action :authenticate_user!, only: [ :index, :show]
  def index
  end

  def show

  end

  def new
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
end

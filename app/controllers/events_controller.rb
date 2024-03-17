class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @events = policy_scope(Event).includes(photo_attachment: :blob).order(date: :desc).limit(8)
  end
end

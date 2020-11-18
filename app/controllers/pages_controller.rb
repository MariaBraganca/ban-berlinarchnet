class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = User.new

    @events = Event.order(start_date: :desc).limit(4)
    @offices = Office.order(:name).limit(3)
    @openings = Opening.order(date: :desc).limit(3).order(:id)
    @posts = Post.order(date: :desc).limit(4)
  end
end

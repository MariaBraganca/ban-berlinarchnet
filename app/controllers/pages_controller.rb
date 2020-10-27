class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = User.new

    @events = Event.order(start_date: :desc).limit(3)
    @offices = Office.order(:name).limit(3)
    @openings = Opening.order(date: :desc).limit(3)
    @posts = Post.order(date: :desc).limit(3)
  end
end

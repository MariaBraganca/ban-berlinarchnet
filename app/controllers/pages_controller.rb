class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = User.new

    @events = Event.all
    @offices = Office.all
    @openings = Opening.all
    @posts = Post.all
  end
end

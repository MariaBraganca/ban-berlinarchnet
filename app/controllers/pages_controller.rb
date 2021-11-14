class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = User.new

    @events = policy_scope(Event).includes(cover_photo_attachment: :blob).order(start_date: :desc).limit(4)
    @offices = policy_scope(Office).includes(:ratings, photo_attachment: :blob).order(:name).limit(3)
    @openings = policy_scope(Opening).includes(:office).order(date: :desc).limit(3).order(:id)
    @posts = policy_scope(Post).includes(:tags, user: :photo_attachment).order(date: :desc).limit(4)
  end
end

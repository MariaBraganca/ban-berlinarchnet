class OpeningsController < ApplicationController
	skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
  	@openings = policy_scope(Opening).order(date: :asc)
  end

  def show
    @opening = Opening.find(params[:id])
    @offices = Office.all
  	authorize @opening
  end
end

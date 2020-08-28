class OpeningsController < ApplicationController
	skip_before_action :authenticate_user!, only: [ :index, :show]

	def index
		@openings = policy_scope(Opening).order(created_at: :desc)
	end

	def show
		@opening = Opening.find(params[:id])
		authorize @opening
	end
end

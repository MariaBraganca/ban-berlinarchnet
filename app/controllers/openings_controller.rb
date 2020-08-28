class OpeningsController < ApplicationController
	def index
		@openings = policy_scope(Opening).order(created_at: :desc)
	end

	def show
		@opening = Openings.find(params[:id])
	end
end

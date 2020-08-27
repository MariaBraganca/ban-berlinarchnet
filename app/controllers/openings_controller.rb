class OpeningsController < ApplicationController
	def index
		@openings = Openings.all
	end

	def show
		@opening = Openings.find(params[:id])
	end
end

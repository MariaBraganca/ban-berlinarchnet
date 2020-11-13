class JobsController < ApplicationController
  def index
    @jobs = policy_scope(Job).order(date: :desc)
  end
end

class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @posts = policy_scope(Post).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
  end
end

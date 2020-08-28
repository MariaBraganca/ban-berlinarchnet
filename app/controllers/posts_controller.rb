class PostsController < ApplicationController
  def index
    @posts = policy_scope(Post).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def edit
  end
end

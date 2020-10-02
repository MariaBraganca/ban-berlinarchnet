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

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.date = Time.now
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
    authorize @post
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

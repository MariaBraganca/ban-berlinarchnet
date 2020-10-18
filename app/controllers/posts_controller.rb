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
    @post = Post.find(params[:id])
    @user = User.find(current_user.id)
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    @post.update!(post_params)
    redirect_to post_path(@post)
    authorize @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :photo)
  end
end

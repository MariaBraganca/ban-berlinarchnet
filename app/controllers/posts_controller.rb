class PostsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @posts = policy_scope(Post).order(created_at: :desc)
  end

  def show
    @comment = Comment.new
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
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
    authorize @post
  end

  def destroy
    @post.destroy
    authorize @post
    
    redirect_to posts_path
  end

  private

  def set_event
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :photo, :tag_list)
  end
end

class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post, only: [:show] 
  before_action :authenticate_user!, only: %i[new create]

  def destroy
    author = @post.author
    @post.destroy
    redirect_to user_posts_path(author), notice: 'Post was successfully deleted.'
  end

  def index
    @user = User.includes(posts: %i[comments likes]).find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    @comments = @post.comments
  
    if user_signed_in?  # Check if the user is authenticated (for Devise)
      @current_like = @post.likes.find_by(author_id: current_user.id)
    else
      @current_like = nil  # Set @current_like to nil or handle it as appropriate for unauthenticated requests
    end
  end
  

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
  def set_post
    @post = Post.find(params[:id]) if params[:id]  # Fetch @post if :id is present in the params
  end
end

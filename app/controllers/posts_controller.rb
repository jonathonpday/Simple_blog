class PostsController < ApplicationController
  def index
    user = User.find_by(id: session[:user_id])
    redirect_to new_login_path unless user
    @posts = Post.includes(:user).all
    
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  

  def edit
    user = User.find_by(id: session[:user_id])
    @post = Post.find(params[:id])

    if user.id != @post.user_id
      flash[:alert] = "Please login to edit your posts"
      redirect_to post_path
    end
  end

  def update
     @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    @post = Post.find(params[:id])
    if user.id != @post.user_id
      flash[:alert] = "Please login to delete your posts"
      redirect_to post_path
    else
      @post.destroy
      redirect_to posts_path
    end
  end

  private

    def post_params
      params.require(:post).permit(:user_id, :title, :body)
    end

end

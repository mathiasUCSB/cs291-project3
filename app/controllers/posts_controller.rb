class PostsController < ApplicationController
    before_action :require_login
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user, only: [:edit, :update, :destroy]
  
    def index
      @posts = Post.includes(:user, :comments).order(created_at: :desc)
    end
  
    def show
      # Display post and associated comments
      @comments = @post.comments.includes(:user)
      @comment = Comment.new
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to root_path
      else
        @error_messages = @post.errors.full_messages
        render :new
      end
    end
  
    def edit
      redirect_to root_path unless @post.user == current_user
    end
  
    def update
      if @post.update(post_params) && @post.user == current_user
        redirect_to root_path(@post)
      else
        @error_messages = @post.errors.full_messages
        render :edit
      end
    end
  
    def destroy
      @post.destroy if @post.user == current_user
      redirect_to root_path
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: 'public/404.html', status: :not_found
    end
  
    def post_params
      params.require(:post).permit(:content)
    end
  
    def authorize_user
      redirect_to root_path unless @post.user == current_user
    end
  end
  
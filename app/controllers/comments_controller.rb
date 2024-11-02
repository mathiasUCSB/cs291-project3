class CommentsController < ApplicationController
    before_action :require_login
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params.merge(user: current_user))
      if @comment.valid?
        @comment.save
        redirect_to post_path(@post)
      else
        @comments = @post.comments.includes(:user)
        @error_messages = @comment.errors.full_messages
        render 'posts/show'
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  
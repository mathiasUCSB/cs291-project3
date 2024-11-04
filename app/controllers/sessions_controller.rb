class SessionsController < ApplicationController
    def new
        # Render login form
      end
    
      def create
        # Find or create user by username
        user = User.find_or_create_by(username: params[:username])
        session[:user_id] = user.id
        redirect_to root_path
      end
    
      def destroy
        session.delete(:user_id)
        redirect_to login_path
      end
end

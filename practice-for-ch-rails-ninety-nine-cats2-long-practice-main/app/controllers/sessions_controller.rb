class SessionsController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:destroy]

    def new
        render :new
    end


    def create
        @user = User.find_by_credentials(params[:user_info][:username], params[:user_info][:password])
        
        if @user
            login(@user)
            redirect_to cats_url
        else
            redirect_to new_session_url
        end
    end


    def destroy
        if logged_in?
            @current_user.reset_session_token!
            session[:session_token] = nil
            @current_user = nil
            redirect_to cats_url
        end
    end

    


end
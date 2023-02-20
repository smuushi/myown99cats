class UsersController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login(@user)
            redirect_to cats_url
        else
            redirect_to new_user_url
        end
    end

    private
    def user_params
        params.require(:user_info).permit(:username, :password)
    end
end
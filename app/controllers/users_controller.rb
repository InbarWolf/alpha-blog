class UsersController < ApplicationController
    
    before_action :set_user, only: [:show]

    def new
        @user = User.new
    end

    def show

    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome #{@user.username}"
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    private 

    def set_user
        @user = User.find(params[:id])
    end
    
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end

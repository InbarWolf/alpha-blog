class UsersController < ApplicationController
    
    before_action :set_user, only: [:show, :edit, :update]

    def new
        @user = User.new
    end

    def show
        @articles = @user.articles.paginate(:page => params[:page], :per_page => 3 )
    end

    def edit

    end

    def index
        @users = User.paginate(:page => params[:page], :per_page => 5 )
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

    def update
        if @user.update(user_params)
            flash[:success] = "USer info was updated!"
            redirect_to user_path(@user)
        else
            render 'edit'
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

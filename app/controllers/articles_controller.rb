class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    before_action :require_user, only: [:new]
    before_action :require_same_user, only: [:edit, :destroy, :update]
    
    def index
        @articles = Article.paginate(:page => params[:page], :per_page => 5 )
    end

    def show

    end

    def destroy
        @article.destroy
        flash[:success] = "Article was deleted!"
        redirect_to articles_path
    end

    def new
        @article = Article.new
    end

    def edit

    end

    def create
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save
            flash[:success] = "Article was saved"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end

    def update
        if @article.update article_params
            flash[:success] = "Article was updated sucessfully"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end


    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if (logged_in? && @article.user && session[:user_id] != @article.user.id)
            flash[:danger] = "Please log in"
            redirect_to root_path
        end
    end
end
class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    params[:article][:category] = Category.find_by_full_name(params[:article][:category])
    if @article.update_attributes(params[:article])
      redirect_to :action => 'show', :id => @article
    end
  end

  def index
  end

  def create
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    @article.save
  end
end

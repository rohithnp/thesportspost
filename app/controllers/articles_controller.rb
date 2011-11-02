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
  end

  def index
  end

  def create
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    @article.save
  end
end
class Admin::ArticlesController < ApplicationController

  def show
    authorize! :manage, Article
    @article = Article.find(params[:id])
  end

  def new
    authorize! :manage, Article
    @article = Article.new
    @categories = Category.all.map {|c| [c.name,c.full_name] }
  end
  
  def edit
    authorize! :manage, Article
    @categories = Category.all.map {|c| [c.name,c.full_name] }
    @article = Article.find(params[:id])
  end
  
  def update
    authorize! :manage, Article
    @article = Article.find(params[:id])
    params[:article][:category] = Category.find_by_full_name(params[:article][:category])
    if @article.update_attributes(params[:article])
      redirect_to :action => :index
    end
  end

  def index
    authorize! :manage, Article
    if current_user.role?(:admin) || current_user.role?(:editor)
      @articles = Article.all
    elsif current_user.role?(:writer)
      @articles = Article.where(:user_id => current_user.id) || []
    end
  end

  def create
    authorize! :manage, Article
    params[:article][:category] = Category.find_by_full_name(params[:article][:category])
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    @article.save
    redirect_to :action => :index
  end
end

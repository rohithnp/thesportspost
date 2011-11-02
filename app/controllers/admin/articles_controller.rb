class Admin::ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @categories = Category.all.map {|c| [c.name,c.full_name] }
  end
  
  def edit
    if can? :manage, Article
      @categories = Category.all.map {|c| [c.name,c.full_name] }
      @article = Article.find(params[:id])
    end
  end
  
  def update
    @article = Article.find(params[:id])
    params[:article][:category] = Category.find_by_full_name(params[:article][:category])
    if @article.update_attributes(params[:article])
      redirect_to :action => :index
    end
  end

  def index
    if current_user.role?(:admin) || current_user.role?(:editor)
      @articles = Article.all
    elsif current_user.role?(:writer)
      @articles = Article.where(:user_id => current_user.id) || []
    end
  end

  def create
    params[:article][:category] = Category.find_by_full_name(params[:article][:category])
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    @article.save
    redirect_to :action => :index
  end
end

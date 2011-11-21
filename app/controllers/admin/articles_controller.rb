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
    if !@article.category.nil?
      @subcategories = [[nil,nil]]
      Subcategory.where(:category_id => @article.category.id).each do |sc|
        @subcategories << [sc.name, sc.name]
      end
    end
  end
  
  def update
    authorize! :manage, Article
    @article = Article.find(params[:id])
    params[:article][:category] = Category.find_by_full_name(params[:article][:category])
    if params[:article][:subcategory]
      params[:article][:subcategory] = Subcategory.find_by_name(params[:article][:subcategory])
    else
      params[:article].delete :subcategory
    end
    if @article.update_attributes(params[:article])
      redirect_to :action => :edit, :id => params[:id]
    end
  end

  def index
    authorize! :manage, Article
    if current_user.role?(:admin) || current_user.role?(:editor)
      @articles = Article.order('created_at DESC')
    elsif current_user.role?(:writer)
      @articles = Article.where(:user_id => current_user.id).order('created_at DESC') || []
    end
  end

  def create
    authorize! :manage, Article
    params[:article][:category] = Category.find_by_full_name(params[:article][:category])
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    @article.save
    if params[:add_to_recent]
      recent_articles = PageSection.find_by_id(1)
      recent_articles.article_ids = recent_articles.article_ids.unshift(@article.id)
      recent_articles.save
    end
    redirect_to :action => :index
  end
end

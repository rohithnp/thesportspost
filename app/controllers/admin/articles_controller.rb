class Admin::ArticlesController < ApplicationController
  before_filter :authorize_user

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @categories = Category.all.map {|c| [c.name,c.full_name] }
    @writer_articles = Article.where(:user_id => current_user.id)
  end
  
  def edit
    @article = Article.find(params[:id])
    @categories = Category.all.map {|c| [c.name,c.full_name] }
    @writer_articles = Article.where(:user_id => @article.user_id)
    @same_category_articles = Article.where(:category_id => @article.category_id)
    if !@article.category.nil?
      @subcategories = [[nil,nil]]
      Subcategory.where(:category_id => @article.category.id).each do |sc|
        @subcategories << [sc.name, sc.name]
      end
    end
  end
  
  def update
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
    if current_user.role?(:admin) || current_user.role?(:editor)
      @articles = Article.order('created_at DESC')
    elsif current_user.role?(:writer)
      @articles = Article.where(:user_id => current_user.id).order('created_at DESC') || []
    end
  end

  def create
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

  def destroy
    @article = Article.find_by_id(params[:id])
    @article.destroy
    redirect_to :action => :index
  end

  protected
  def authorize_user
    authorize! :manage, Article
  end
end

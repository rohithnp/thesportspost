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
    @headlines = ArticleSet.headlines
    @slideshow = ArticleSet.slideshow
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
    params[:article][:is_draft] = params[:article][:is_draft] == 'on' ? true : false
    params[:article][:category] = Category.find_by_full_name(params[:article][:category])
    if params[:article][:subcategory]
      params[:article][:subcategory] = Subcategory.find_by_name(params[:article][:subcategory])
    else
      params[:article].delete :subcategory
    end
    @article.article_type = params[:article][:article_type].to_i if params[:article][:article_type]
    if params[:add_to_recent]
      recent_articles = ArticleSet.recent_articles
      recent_articles.add_article @article.id
      recent_articles.save
    end
    s = ArticleSet.slideshow
    if params[:add_to_slideshow] and @article.image?
      s.add_article(@article.id)
      s.save
    elsif s.article_ids.include? @article.id
      s.article_ids.delete @article.id
      s.save
    end
    h = ArticleSet.headlines
    if params[:add_to_headlines]
      h.add_article(@article.id)
      h.save
    elsif h.article_ids.include? @article.id
      h.article_ids.delete @article.id
      h.save
    end
    if @article.update_attributes(params[:article])
      redirect_to :action => :edit, :id => @article.slug
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
    params[:article][:is_draft] = params[:article][:is_draft] == 'on' ? true : false
    params[:article][:category] = Category.find_by_full_name(params[:article][:category])
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    @article.save
    if params[:add_to_recent]
      recent_articles = ArticleSet.recent_articles
      recent_articles.add_article @article.id
      recent_articles.save
    end
    s = ArticleSet.slideshow
    if params[:add_to_slideshow] and @article.image?
      s.add_article(@article.id)
      s.save
    elsif s.article_ids.include? @article.id
      s.article_ids.delete @article.id
      s.save
    end
    h = ArticleSet.headlines
    if params[:add_to_headlines]
      h.add_article(@article.id)
      h.save
    elsif h.article_ids.include? @article.id
      h.article_ids.delete @article.id
      h.save
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

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_categories
  before_filter :dont_accept_crap_query_params

  def index
    @headlines = ArticleSet.headlines
    @slideshow = ArticleSet.slideshow
    @recent_articles = ArticleSet.recent_articles
    @observation_deck = ArticleSet.observation_deck
    @popular_posts = Article.is_live.order('pageviews DESC').limit(20)
    @top_post = @popular_posts.shift
  end

  protected
  def get_categories
    @navbar_categories = Category.limit(4).order('id DESC')
  end

  def dont_accept_crap_query_params
    if params[:controller] == 'application' and params[:action] == 'index'
      return redirect_to(root_url) if params[:q]
    end
  end
end

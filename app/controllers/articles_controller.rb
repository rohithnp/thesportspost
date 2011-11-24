class ArticlesController < ApplicationController
  def show
    @article = Article.find_by_slug(params[:id])
    unless @article
      # raise ActionController::RoutingError.new('Not Found')
      return redirect_to '/'
    end
    @article.pageviews ||= 0
    @article.pageviews += 1
    @article.save
    @related_articles = if @article.related_articles.length > 0
      @article.related_articles
    else
      Article.where(:category_id => @article.category_id).order('created_at DESC').limit(5)
    end
    @same_writer_articles = if @article.same_writer_articles.length > 0
      @article.same_writer_articles
    else
      Article.where(:user_id => @article.user_id).order('created_at DESC').limit(5)
    end
  end
end

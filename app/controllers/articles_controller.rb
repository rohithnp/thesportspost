class ArticlesController < ApplicationController
  def show
    @article = Article.find_by_slug(params[:id])
    unless @article
      # raise ActionController::RoutingError.new('Not Found')
      redirect_to '/'
    end
    @article.pageviews ||= 0
    @article.pageviews += 1
    @article.save
  end
end

class ArticlesController < ApplicationController
  def show
    @article = Article.find_by_slug(params[:id])
    unless @article
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end

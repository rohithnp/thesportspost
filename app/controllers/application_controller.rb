class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @headlines = Article.limit(7)
    @posts = Article.limit(5)
  end
end

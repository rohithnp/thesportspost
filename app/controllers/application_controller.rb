class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @posts = Article.limit(5)
  end
end

class ArticlesController < ApplicationController
  def new
  end

  def show
    @article = Article.find(params[:id])
    unless @article
      redirect_to '/'
    end
  end

  def edit

  end
end

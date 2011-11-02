class Admin::ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def edit
    if can? :manage, Article
      @categories = Category.all.map {|c| [c.name,c.full_name] }
      @article = Article.find(params[:id])
    end
  end

  def index
    if current_user.role?(:admin) || current_user.role?(:editor)
      @articles = Article.all
    elsif current_user.role?(:writer)
      @articles = Article.where(:user_id => current_user.id) || []
    end
  end
end

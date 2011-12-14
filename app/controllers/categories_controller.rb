class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @category = Category.find_by_name(params[:category].to_s.downcase)
    unless @category
      raise ActionController::RoutingError.new('Not Found')
    end
    @articles = Article.is_live.where(:category_id => @category.id).order('created_at DESC')
    @popular_articles = Article.is_live.where(:category_id => @category.id).order('pageviews DESC')
    @slideshow = Article.is_live.where(['category_id = ? AND image_file_name IS NOT NULL', @category.id]).limit(5)
    @headlines = @articles[0..10]
  end

  def update
    category = Category.find(params[:id])
    category.update_attributes(params[:category])
    redirect_to :controller => 'admin/categories', :action => 'index'
  end
end

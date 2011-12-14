class SubcategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @category = Category.find_by_name(params[:category])
    @subcategory = Subcategory.where(:category_id => @category.id, :slug => params[:subcategory]).first
    unless @subcategory
      raise ActionController::RoutingError.new('Not Found')
    end
    @articles = Article.is_live.where(:subcategory_id => @subcategory.id).limit(10)
    @slideshow = Article.is_live.where(['subcategory_id = ? AND image_file_name IS NOT NULL', @subcategory.id]).limit(5)
    @headlines = @articles[0..5]
  end

  def create
    @subcategory = Subcategory.new(params[:subcategory])
    @subcategory.category_id = params[:category_id]
    @subcategory.save
    redirect_to :controller => 'admin/categories', :action => 'index'
  end

  def destroy
    @subcategory = Subcategory.find(params[:id])
    @subcategory.destroy
    redirect_to :controller => 'admin/categories', :action => 'index'
  end
end

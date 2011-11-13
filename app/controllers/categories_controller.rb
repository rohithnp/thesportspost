class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @category = Category.find_by_name(params[:id].to_s.downcase)
    unless @category
      raise ActionController::RoutingError.new('Not Found')
    end
    @articles = Article.where(:category_id => @category.id).limit(10)
  end

  def update
    category = Category.find(params[:id])
    category.update_attributes(params[:category])
    redirect_to 'admin#index'
  end
end

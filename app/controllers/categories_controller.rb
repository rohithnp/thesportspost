class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_name(params[:id].to_s.downcase)
    unless @category
      raise ActionController::RoutingError.new('Not Found')
    end
    @articles = Article.where(:category_id => @category.id).limit(10)
  end
end

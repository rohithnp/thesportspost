class SubcategoriesController < ApplicationController
  load_and_authorize_resource

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

class SubcategoriesController < ApplicationController
  load_and_authorize_resource

  def create
    @subcategory = Subcategory.new(params[:subcategory])
    @subcategory.category_id = params[:category_id]
    if @subcategory.save
      redirect_to 'admin#index'
    end
  end

  def destroy
    @subcategory = Subcategory.find(params[:id])
    if @subcategory.destroy
      redirect_to 'admin#index'
    end
  end
end

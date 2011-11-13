class Admin::CategoriesController < ApplicationController

  def index
    authorize! :manage, Subcategory
    @categories = Category.all
  end
end

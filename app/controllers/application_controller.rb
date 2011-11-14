class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_categories

  def index
    @headlines = Article.limit(5)
    @slideshow = Article.where('image_file_name IS NOT NULL').limit(5)
    @page_sections = PageSection.all[0..1]
    @posts = Article.limit(8)
  end

  protected
  def get_categories
    @navbar_categories = Category.limit(4)
  end
end

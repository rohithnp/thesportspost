class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_categories
  before_filter :dont_accept_crap_query_params

  def index
    @headlines = Article.order('created_at DESC').limit(10)
    @slideshow = Article.where('image_file_name IS NOT NULL').order('created_at DESC').limit(5)
    @page_sections = PageSection.all[0..1]
    @page_section = PageSection.first
    @posts = Article.order('created_at DESC').limit(9)
  end

  protected
  def get_categories
    @navbar_categories = Category.limit(4).order('id DESC')
  end

  def dont_accept_crap_query_params
    if params[:controller] == 'application' and params[:action] == 'index'
      return redirect_to(root_url) if params[:q]
    end
  end
end

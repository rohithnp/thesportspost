class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_categories
  before_filter :dont_accept_crap_query_params

  def index
    @headlines = Headlines.first
    @slideshow = Slideshow.first
    @page_sections = PageSection.all[0..1]
    @page_section = PageSection.first
    @popular_posts = Article.order('pageviews DESC').limit(12)
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

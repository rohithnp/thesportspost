class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_categories

  def index
    @headlines = Article.limit(7)
    @slideshow = Article.where('image_file_name IS NOT NULL').limit(3).map {|a|
      {
        :src => "http://localhost:3000#{a.image.url(:big)}",
        :link => "/articles/#{a.slug}",
        :name => a.title
      }
    }.to_json
    @posts = Article.limit(5)
  end

  protected
  def get_categories
    @navbar_categories = Category.limit(4)
  end
end

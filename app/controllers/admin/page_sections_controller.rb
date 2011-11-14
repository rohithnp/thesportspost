class Admin::PageSectionsController < ApplicationController

  def index
    @page_section = PageSection.first
    @articles = Article.all[0..100]
  end

  def update
    @page_section = PageSection.find(params[:id])
    if @page_section.update_attributes(params[:page_section])
      redirect_to :action => :index
    end
  end
end

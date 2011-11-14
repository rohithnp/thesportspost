class Admin::PageSectionsController < ApplicationController

  def index
    @page_section = PageSection.first
  end
end

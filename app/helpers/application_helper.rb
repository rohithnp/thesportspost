module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def resource
    @resource ||= User.new
  end

  def resource_name
    :user
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end

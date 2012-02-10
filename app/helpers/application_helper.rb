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

  def article_text_sample(article, limit=100)
    cleaned_text = strip_tags(article.text.strip).gsub(/\s+/,' ').gsub(/&nbsp;/,' ').strip
    (truncate cleaned_text, :length => limit).html_safe
  end
end

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
    cleaned_text = strip_tags(article.text.strip).gsub(/\s+/,' ').gsub(/&nbsp;/,' ').strip.split
    if cleaned_text
      text = ""
      i = 0
      while text.length<[limit,cleaned_text.length].min
        text += cleaned_text[i] + " "
        i += 1
      end
      text += "..."
      text.html_safe
    else
      ""
    end
  end
end

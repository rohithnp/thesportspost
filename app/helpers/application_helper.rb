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
    text = ""
    i = 0
    while text.length<limit
      text += cleaned_text[i] + " "
      i += 1
    end
    text += "..."
    text.html_safe
  end

  def adsense_top_right
    '<script type="text/javascript"><!--
    google_ad_client = "ca-pub-1214541924352395";
    /* Top Banner Ad */
    google_ad_slot = "2983044274";
    google_ad_width = 336;
    google_ad_height = 280;
    //-->
    </script>
    <script type="text/javascript"
    src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
    </script>'
  end

  def adsense_under_headlines
    '<script type="text/javascript"><!--
    google_ad_client = "ca-pub-1214541924352395";
    /* Small Box Under Headlines */
    google_ad_slot = "1686483643";
    google_ad_width = 250;
    google_ad_height = 250;
    //-->
    </script>
    <script type="text/javascript"
    src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
    </script>'
  end
end

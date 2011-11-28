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
    src="">
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
    src="">
    </script>'
  end
end

class PageSection < ActiveRecord::Base
  before_save :serialize_article_ids

  def article_ids
    ActiveSupport::JSON.decode(serialized_article_ids)
  end

  def articles
    article_ids
  end

  private
  def serialize_article_ids
    seralized_article_ids = ActiveSupport::JSON.encode(article_ids)
  end
end

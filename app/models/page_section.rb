class PageSection < ActiveRecord::Base

  def article_ids
    ActiveSupport::JSON.decode(serialized_article_ids).map {|a| a.to_i }
  end

  def article_ids=(article_ids)
    self.serialized_article_ids = ActiveSupport::JSON.encode(article_ids)
  end

  def articles
    Article.is_live.where(:id => article_ids.map {|a| a.to_i }).order('created_at DESC')
  end
end

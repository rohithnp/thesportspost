class PageSection < ActiveRecord::Base

  def article_ids
    ActiveSupport::JSON.decode(serialized_article_ids).map {|a| a.to_i }
  end

  def article_ids=(article_ids)
    self.serialized_article_ids = ActiveSupport::JSON.encode(article_ids)
  end

  def articles
    Article.where(:id => article_ids.map {|a| a.to_i })
  end
end

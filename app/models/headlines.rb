class Headlines < ActiveRecord::Base
  serialize :article_ids, Array
  before_save :unique_article_ids

  def add_article(id)
    article_ids.unshift(id) unless article_ids.include?(id)
    self.article_ids = article_ids.take(12)
  end

  def articles
    article_ids.take(12).map {|id|
      a = Article.find_by_id(id)
      a.try(:is_draft) ? nil : a
    }.compact
  end

  private
    def unique_article_ids
      self.article_ids = article_ids.uniq
    end
end

class Slideshow < ActiveRecord::Base
  serialize :article_ids, Array
  before_save :unique_article_ids

  def add_article(id)
    article_ids.unshift(id) unless article_ids.include?(id)
    self.article_ids = article_ids.take(5)
  end

  def articles
    article_ids.take(5).map {|id|
      a = Article.find_by_id(id)
      a and a.is_draft ? nil : a
    }.delete_if(&:nil?)
  end

  private
    def unique_article_ids
      self.article_ids = article_ids.uniq
    end
end

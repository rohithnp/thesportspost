class ArticleSet < ActiveRecord::Base
  serialize :article_ids, Array
  after_initialize :set_max_articles
  before_save :filter_article_ids

  class << self
    def slideshow(category_name = nil)
      set = if category_name
        category = Category.find_by_name(category_name)
        find_or_create_by_slug_and_category_id('slideshow', category.id)
      else
        find_or_create_by_slug('slideshow')
      end
      set.max_articles = 5
      set
    end

    def headlines(category_name = nil)
      set = if category_name
        category = Category.find_by_name(category_name)
        find_or_create_by_slug_and_category_id('headlines', category.id)
      else
        find_or_create_by_slug('headlines')
      end
      set
    end

    def recent_articles
      find_or_create_by_slug_and_full_name('recent-articles', 'Recent Articles')
    end

    def observation_deck
      find_or_create_by_slug_and_full_name('observation-deck', 'Observation Deck')
    end
  end

  def add_article(id)
    article_ids.unshift(id) unless article_ids.include?(id)
    self.article_ids = article_ids.take(max_articles)
  end

  def articles
    article_ids.take(max_articles).map {|id|
      a = Article.find_by_id(id)
      a.try(:is_draft) ? nil : a
    }.compact
  end

  private
    def set_max_articles
      self.max_articles ||= 10
    end

    def filter_article_ids
      self.article_ids = article_ids.uniq.take(max_articles)
    end
end
